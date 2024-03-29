package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.benmanes.caffeine.cache.Cache;
import lombok.extern.slf4j.Slf4j;
import org.eclipse.paho.client.mqttv3.MqttMessage;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.common.config.properties.SystemProperties;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.common.utils.PushUtil;
import pro.dengyi.myhome.common.utils.UserHolder;
import pro.dengyi.myhome.dao.*;
import pro.dengyi.myhome.model.TreeDto;
import pro.dengyi.myhome.model.device.*;
import pro.dengyi.myhome.model.device.dto.*;
import pro.dengyi.myhome.model.dto.ChangeFavoriteDto;
import pro.dengyi.myhome.model.system.Family;
import pro.dengyi.myhome.model.system.Floor;
import pro.dengyi.myhome.model.system.Room;
import pro.dengyi.myhome.model.system.User;
import pro.dengyi.myhome.service.DeviceService;

import javax.annotation.Resource;
import java.nio.charset.StandardCharsets;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-25
 */
@Slf4j
@Service
public class DeviceServiceImpl implements DeviceService {

    @Autowired
    private DeviceDao deviceDao;
    @Autowired
    private DeviceLogDao deviceLogDao;
    @Autowired
    private FloorDao floorDao;
    @Autowired
    private SystemProperties systemProperties;
    @Autowired
    private FramewareDao framewareDao;
    @Autowired
    private RoomDao roomDao;
    @Autowired
    private DeviceUserFavoriteDao deviceUserFavoriteDao;
    @Autowired
    private ProductDao productDao;
    @Autowired
    private ProductFieldDao productFieldDao;
    @Resource
    private Cache systemCache;
    @Autowired
    private UserDao userDao;
    @Autowired
    private FamilyDao familyDao;


    @Override
    public Device selectById(String deviceId) {
        return deviceDao.selectById(deviceId);
    }

    @Transactional
    @Override
    public void addUpdate(Device device) {
        //todo do product cache by id
        Product product = productDao.selectById(device.getProductId());
        //没有取名是直接将产品名当做设备名
        if (ObjectUtils.isEmpty(device.getName())) {
            device.setName(product.getName());
        }
        if (ObjectUtils.isEmpty(device.getId())) {

            if (!ObjectUtils.isEmpty(device.getChipId())) {
                device.setId(device.getChipId());

            }
            //新增，默认离线，默认启用,固件版本为1
            device.setEnable(true);
            //不可控设备默认在线
            device.setOnline(!product.getCanControl());
            device.setFramewareVersion(1);
            device.setCreateTime(LocalDateTime.now());
            device.setUpdateTime(LocalDateTime.now());
            deviceDao.insert(device);
        } else {
            //更新
            device.setOnline(!product.getCanControl());
            device.setUpdateTime(LocalDateTime.now());
            deviceDao.updateById(device);
        }

    }

    @Transactional
    @Override
    public void delete(String id) {
        //todo 做其他判断
        deviceDao.deleteById(id);
    }

    @Override
    public IPage<DeviceDto> page(Integer pageNumber, Integer pageSize,
                                 String familyId, String floorId, String roomId,
                                 String categoryId) {
        IPage<DeviceDto> pageParam = new Page<>(
                pageNumber == null ? 1 : pageNumber,
                pageSize == null ? 10 : pageSize);
        return deviceDao.selectCustomPage(pageParam, familyId, floorId, roomId,
                categoryId);
    }

    @Override
    public List<Device> debugDeviceList(String productId) {

        LambdaQueryWrapper<Device> wrapper = new LambdaQueryWrapper<>();
        if (!ObjectUtils.isEmpty(productId)) {
            wrapper.eq(Device::getProductId, productId);
        }
        return deviceDao.selectList(wrapper);
    }

    @Transactional
    @Override
    public void sendDebug(Map<String, Object> orderMap) {
        //严格校验权限，但是不严格校验内容，能够使用此接口的必须先保证权限

        String deviceId = (String) orderMap.get("deviceId");
        Device device = deviceDao.selectById(deviceId);
        if (device.getOnline()) {
            //1.构造控制topic
            //2024-01-06决定取消产品ID
            String controlTopic = "control/" + device.getId();
//            MqttMessage message = new MqttMessage(JSON.toJSONString(orderMap)
//                    .getBytes(StandardCharsets.UTF_8));
//            message.setQos(1);
//            try {
//                mqttClient.publish(controlTopic, message);
//                DeviceLog deviceLog = new DeviceLog(device.getProductId(),
//                        deviceId, controlTopic, JSON.toJSONString(orderMap),
//                        "down");
//                DeviceLogQueue.publish(deviceLog);
//            } catch (MqttException e) {
//                log.error("发送命令失败", e);
//            }
        } else {
            throw new BusinessException(18002, "设备离线不能发送命令");
        }
    }

    @Transactional
    @Override
    public void emqHook(Map<String, Object> params) {
        log.warn("设备状态发生改变，数据为:{}", params);
        String clientId = (String) params.get("clientid");
        //排除管理后台改变
        if (systemProperties.getMqttClientIds().contains(clientId)) {
            return;
        }
        String eventType = (String) params.get("event");
        Device device = deviceDao.selectById(clientId);
        if ("client.connected".equals(eventType)) {
            device.setOnline(true);
            PushUtil.onOffLinePush(device.getId(), device.getName(), true);
        } else {
            device.setOnline(false);
            //设备端是没有用户缓存的！！！
            PushUtil.onOffLinePush(device.getId(), device.getName(), false);
        }
        device.setUpdateTime(LocalDateTime.now());
        deviceDao.updateById(device);
    }

    @Override
    @Transactional
    public void deviceOnline(String clientId) {
        Device device = deviceDao.selectById(clientId);
        device.setOnline(true);
        deviceDao.updateById(device);
    }

    @Override
    public void singleDeviceFirmwareUpdate(DeviceDto deviceDto) {
        String otaTopic = "ota/" + deviceDto.getProductId() + "/" + deviceDto.getId();
        //查询最新的固件
        Frameware frameware = framewareDao.selectOne(
                new LambdaQueryWrapper<Frameware>().eq(Frameware::getProductId,
                                deviceDto.getProductId())
                        .orderByDesc(Frameware::getVersion).last("limit 1"));

        OtaParam otaParam = new OtaParam();
        otaParam.setDeviceId(deviceDto.getId());
        otaParam.setTargetVersion(frameware.getVersion());
        otaParam.setTargetUrl(frameware.getUrl());

//        String otaString = JSON.toJSONString(otaParam);

//        MqttMessage message = new MqttMessage(otaString.getBytes(StandardCharsets.UTF_8));
//        message.setQos(1);
//        try {
//            mqttClient.publish(otaTopic, message);
////      DeviceLog deviceLog = new DeviceLog();
////      deviceLog.setProductId(deviceDto.getProductId());
////      deviceLog.setDeviceId(deviceDto.getId());
////      deviceLog.setTopicName(otaTopic);
////      deviceLog.setPayload(otaString);
////      deviceLog.setDirection(1);
////      deviceLog.setCreateTime(LocalDateTime.now());
////      deviceLog.setUpdateTime(LocalDateTime.now());
////      deviceLogDao.insert(deviceLog);
//        } catch (MqttException e) {
//            log.error("发送命令失败", e);
//        }

    }

    @Override
    public void sendCmd(Map<String, Object> orderMap) {
        String deviceId = (String) orderMap.get("deviceId");
        Device device = deviceDao.selectById(deviceId);
        String cmdContent = (String) orderMap.get("cmdContent");
        //1. 是否有权限，2.是否在线，3.命令是否正确
        //todo 严格校验
        if (device.getOnline()) {
            String controlTopic = "control/" + device.getProductId() + "/" + device.getId();
            MqttMessage message = new MqttMessage(
                    cmdContent.getBytes(StandardCharsets.UTF_8));
            message.setQos(1);
//            try {
//                mqttClient.publish(controlTopic, message);
//                DeviceLog deviceLog = new DeviceLog(device.getProductId(), device.getId(), controlTopic,
//                        cmdContent, "down", "man", UserHolder.getUser().getId());
//                DeviceLogQueue.publish(deviceLog);
//            } catch (MqttException e) {
//                log.error("发送命令失败", e);
//            }

        }


    }

    @Override
    public List<RoomDeviceTree> roomDeviceTree(String floorId) {

        List<String> floorIds = new ArrayList<>();
        if (ObjectUtils.isEmpty(floorId)) {
            List<Object> floorIdList = floorDao.selectObjs(
                    new LambdaQueryWrapper<Floor>().select(Floor::getId));
            if (!CollectionUtils.isEmpty(floorIdList)) {
                for (Object obj : floorIdList) {
                    floorIds.add((String) obj);
                }
            }
        } else {
            floorIds.add(floorId);
        }
        List<Room> rooms = roomDao.selectList(
                new LambdaQueryWrapper<Room>().in(Room::getFloorId, floorIds));
        List<RoomDeviceTree> roomDeviceTreeList = new ArrayList<>();
        if (!CollectionUtils.isEmpty(rooms)) {
            for (Room room : rooms) {
                RoomDeviceTree root = new RoomDeviceTree();
                root.setFloorId(room.getFloorId());
                root.setId(room.getId());
                root.setName(room.getName());
                root.setType("room");
                List<Device> devices = deviceDao.selectList(
                        new LambdaQueryWrapper<Device>().eq(Device::getRoomId,
                                room.getId()));
                List<RoomDeviceTree> leaf = genLeaf(devices);
                root.setChildren(leaf);
                roomDeviceTreeList.add(root);
            }
        }
        return roomDeviceTreeList;
    }

    @Override
    public List<DeviceDto> listByRoomId(String roomId, Boolean favorite) {

        //todo 缓存
        List<DeviceDto> deviceDtos = deviceDao.listByRoomId(roomId,
                UserHolder.getUser(), favorite);

        if (!CollectionUtils.isEmpty(deviceDtos)) {
            for (DeviceDto deviceDto : deviceDtos) {
                Product product = productDao.selectById(
                        deviceDto.getProductId());
                deviceDto.setProduct(product);
                List<ProductField> productFieldList = productFieldDao.selectList(
                        new LambdaQueryWrapper<ProductField>().eq(
                                ProductField::getProductId, product.getId()));
                deviceDto.setProductFieldList(productFieldList);

                DeviceLog deviceLog = null;
                if ("1604724519529963522".equals(product.getId())) {
                    List<DeviceLog> deviceLogs = deviceLogDao.selectList(
                            new LambdaQueryWrapper<DeviceLog>().eq(
                                            DeviceLog::getDeviceId, deviceDto.getId())
                                    .orderByDesc(DeviceLog::getCreateTime)
                                    .eq(DeviceLog::getDirection, "up")
                                    .last("limit 100"));

                    for (int i = 0; i <= deviceLogs.size() - 1; i++) {

//                        Map map = JSON.parseObject(deviceLogs.get(i).getPayload(), Map.class);
//                        if ((int) map.get("pm10") != 65535) {
//                            deviceLog = deviceLogs.get(i);
//                            break;
//                        }
                    }

                } else {
                    deviceLog = deviceLogDao.selectOne(
                            new LambdaQueryWrapper<DeviceLog>().eq(
                                            DeviceLog::getDeviceId, deviceDto.getId())
                                    .orderByDesc(DeviceLog::getCreateTime)
                                    .eq(DeviceLog::getDirection, "up")
                                    .last("limit 1"));
                }

                deviceDto.setCurrentStatus(
                        deviceLog != null ? deviceLog.getPayload() : null);
            }
        }
        return deviceDtos;
    }

    @Transactional
    @Override
    public void changeFavorite(ChangeFavoriteDto favoriteDto) {

        //todo 队列

        if (favoriteDto.getFavorite()) {
            DeviceUserFavorite favorite = new DeviceUserFavorite();
            favorite.setDeviceId(favoriteDto.getDeviceId());
            favorite.setUserId(UserHolder.getUser().getId());
            favorite.setCreateTime(LocalDateTime.now());
            favorite.setUpdateTime(LocalDateTime.now());
            deviceUserFavoriteDao.insert(favorite);
        } else {
            deviceUserFavoriteDao.delete(
                    new LambdaQueryWrapper<DeviceUserFavorite>().eq(
                                    DeviceUserFavorite::getDeviceId,
                                    favoriteDto.getDeviceId())
                            .eq(DeviceUserFavorite::getUserId,
                                    UserHolder.getUser().getId()));
        }

//    Device device = deviceDao.selectById(favoriteDto.getDeviceId());
//    cache.invalidate("listByRoomId:" + UserHolder.getUser().getId() + ":" + device.getRoomId() + ":"
//        + favoriteDto.getFavorite());

    }

    @Override
    public List<Map<String, Object>> mapModeLamps(String floorId) {
        List<Map<String, Object>> res = new ArrayList<>();
        List<Room> rooms = roomDao.selectList(
                new LambdaQueryWrapper<Room>().eq(Room::getFloorId, floorId));

        if (!CollectionUtils.isEmpty(rooms)) {
            for (Room room : rooms) {
                Map<String, Object> map = new HashMap<>();
                map.put("roomId", room.getId());
                Device device = deviceDao.selectOne(
                        new LambdaQueryWrapper<Device>().eq(Device::getRoomId,
                                        room.getId())
                                .in(Device::getProductId, "1611639914035765249",
                                        "1592058799966867458",
                                        "1611640160472096770")
                                .orderByDesc(Device::getUpdateTime)
                                .last("limit 1"));
                if (device != null) {
                    map.put("deviceId", device.getId());
                    map.put("deviceOnline", device.getOnline());
                    DeviceLog deviceLog = deviceLogDao.selectOne(
                            new LambdaQueryWrapper<DeviceLog>().eq(
                                            DeviceLog::getDeviceId, device.getId())
                                    .orderByDesc(DeviceLog::getCreateTime)
                                    .last("limit 1"));
                    map.put("currentStatus",
                            deviceLog == null ? null : deviceLog.getPayload());
                }
                res.add(map);
            }
        }
        return res;
    }

    @Override
    public List<DeviceForScene> allDeviceList(String floorId, String roomId) {
        LambdaQueryWrapper<Device> qr = new LambdaQueryWrapper<>();
        if (!ObjectUtils.isEmpty(floorId)) {
            qr.eq(Device::getFloorId, floorId);
        }
        if (!ObjectUtils.isEmpty(roomId)) {
            qr.eq(Device::getRoomId, roomId);
        }
        List<Device> devices = deviceDao.selectList(qr);
        List<DeviceForScene> forSceneList = new ArrayList<>();

        if (!CollectionUtils.isEmpty(devices)) {
            for (Device device : devices) {
                DeviceForScene singleObj = new DeviceForScene();
                BeanUtils.copyProperties(device, singleObj);

                Product product = (Product) systemCache.get(
                        "product:" + device.getProductId(),
                        k -> productDao.selectById(device.getProductId()));

                singleObj.setProduct(product);

                List<ProductField> productFields = (List<ProductField>) systemCache.get(
                        "productFields::" + device.getProductId(),
                        key -> productFieldDao.selectList(
                                new LambdaQueryWrapper<ProductField>().eq(
                                        ProductField::getProductId,
                                        device.getProductId())));
                singleObj.setProductFields(productFields);
                Room room = (Room) systemCache.get("room::" + device.getRoomId(),
                        key -> roomDao.selectById(device.getRoomId()));
                singleObj.setRoom(room);
                forSceneList.add(singleObj);
            }
        }

        return forSceneList;
    }

    @Override
    public List<DeviceControlLogDto> deviceControlLog(String userId,
                                                      String roomId,
                                                      String deviceId,
                                                      LocalDateTime startTime,
                                                      LocalDateTime endTime,
                                                      Integer page,
                                                      Integer size) {
        if (page == null) {
            page = 1;
        }
        if (size == null) {
            size = 50;
        }
        return deviceDao.deviceControlLog(userId, roomId, deviceId, startTime,
                endTime, page, size);
    }

    @Override
    public List<FavoriteDevicesModel> favoriteDevices() {
        List<FavoriteDevicesModel> li = new ArrayList<>();

        List<Room> rooms = deviceDao.selectAllRooms(
                UserHolder.getUser().getId());

        if (!CollectionUtils.isEmpty(rooms)) {

            for (Room room : rooms) {
                FavoriteDevicesModel m = new FavoriteDevicesModel();
                m.setRoom(room);
                List<DeviceDto> deviceDtos = this.listByRoomId(room.getId(),
                        true);
                m.setDeviceDtos(deviceDtos);
                li.add(m);
            }
        }

        return li;
    }

    @Override
    public void oneButton(Map<String, Object> orderMap) {
        User user = userDao.selectById(UserHolder.getUser().getId());
//        if (user.getSuperAdmin() || "1632628475547410434".equals(
//                user.getRoleId())) {
//            String type = (String) orderMap.get("type");
//            switch (type) {
//                case "switch":
//                    String status = (String) orderMap.get("status");
//                    String floorId = (String) orderMap.get("floorId");
//                    List<Device> devices = deviceDao.selectList(
//                            new LambdaQueryWrapper<Device>().eq(
//                                    Device::getOnline, true));
//                    String cmdContent = null;
//
//                    if ("open".equals(status)) {
//                        //一键全开
//                        cmdContent = "{\"ch1\":true,\"ch2\":true,\"ch3\":true}";
//                    } else if ("close".equals(status)) {
//                        //一键全关
//                        cmdContent = "{\"ch1\":false,\"ch2\":false,\"ch3\":false}";
//                    }
//                    for (Device device : devices) {
//                        String controlTopic = "control/" + device.getProductId() + "/" + device.getId();
//                        MqttMessage message = new MqttMessage(
//                                cmdContent.getBytes(StandardCharsets.UTF_8));
//                        System.out.println(message);
//                        message.setQos(1);
////                        try {
////                            mqttClient.publish(controlTopic, message);
////                            DeviceLog deviceLog = new DeviceLog(device.getProductId(), device.getId(),
////                                    controlTopic,
////                                    cmdContent, "down", "onebutton", UserHolder.getUser().getId());
////                            DeviceLogQueue.publish(deviceLog);
////                        } catch (MqttException e) {
////                            log.error("发送命令失败", e);
////                        }
//                    }
//
//                    break;
//                default:
//                    log.error("未支持一键类型");
//            }
//
//        }
    }

    @Override
    public List<TreeDto> familyDeviceTree() {
        List<Family> families = familyDao.selectList(null);
        List<TreeDto> familyDtos = new ArrayList<>();
        families.forEach(family -> {
            TreeDto familyDto = new TreeDto();
            familyDto.setId(family.getId());
            familyDto.setName(family.getName());
            //get floor
            List<Floor> floors = floorDao.selectList(
                    new LambdaQueryWrapper<Floor>().eq(Floor::getFamilyId,
                            family.getId()));
            List<TreeDto> floorDtos = new ArrayList<>();
            floors.forEach(floor -> {
                TreeDto floorDto = new TreeDto();
                floorDto.setId(floor.getId());
                floorDto.setName(floor.getName());

                List<Room> rooms = roomDao.selectList(
                        new LambdaQueryWrapper<Room>().eq(Room::getFloorId,
                                floor.getId()));
                List<TreeDto> roomDtos = new ArrayList<>();
                rooms.forEach(room -> {

                    TreeDto roomDto = new TreeDto();
                    roomDto.setId(room.getId());
                    roomDto.setName(room.getName());
                    List<Device> devices = deviceDao.selectList(
                            new LambdaQueryWrapper<Device>().eq(
                                    Device::getRoomId, room.getId()));
                    List<TreeDto> deviceDtos = new ArrayList<>();
                    devices.forEach(device -> {
                        TreeDto deviceDto = new TreeDto();
                        deviceDto.setId(device.getId());
                        deviceDto.setName(device.getName());
                        deviceDto.setGateway(device.getGateway());
                        deviceDtos.add(deviceDto);
                    });
                    roomDto.setChildren(deviceDtos);
                    if (!deviceDtos.isEmpty()) {
                        roomDtos.add(roomDto);
                    }
                });
                floorDto.setChildren(roomDtos);
                if (!roomDtos.isEmpty()) {
                    floorDtos.add(floorDto);
                }
            });
            familyDto.setChildren(floorDtos);
            if (!floorDtos.isEmpty()) {
                familyDtos.add(familyDto);
            }
        });
        return familyDtos;
    }

    @Override
    public List<Device> debugDeviceList() {
        return deviceDao.selectList(null);
    }

    private List<RoomDeviceTree> genLeaf(List<Device> devices) {
        List<RoomDeviceTree> list = new ArrayList<>();
        if (!CollectionUtils.isEmpty(devices)) {
            for (Device device : devices) {
                RoomDeviceTree tree = new RoomDeviceTree();
                tree.setType("device");
                tree.setFloorId(device.getFloorId());
                tree.setId(device.getId());
                tree.setName(device.getName());
                list.add(tree);
            }
        }
        return list;
    }
}
