package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.github.benmanes.caffeine.cache.Cache;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.common.exception.BusinessException;
import pro.dengyi.myhome.common.utils.FamilyHolder;
import pro.dengyi.myhome.dao.FloorDao;
import pro.dengyi.myhome.dao.RoomDao;
import pro.dengyi.myhome.model.dto.FloorPageDto;
import pro.dengyi.myhome.model.system.Floor;
import pro.dengyi.myhome.model.system.Room;
import pro.dengyi.myhome.service.FloorService;

import java.time.LocalDateTime;
import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Service
public class FloorServiceImpl implements FloorService {

    @Autowired
    private FloorDao floorDao;
    @Autowired
    private RoomDao roomDao;
    @Autowired
    private Cache cache;


    @Transactional
    @Override
    public void addUpdate(Floor floor) {
        Floor existFloor = floorDao.selectOne(
                new LambdaQueryWrapper<Floor>().eq(Floor::getName, floor.getName())
                        .eq(Floor::getFamilyId, FamilyHolder.familyId())
        );
        if (ObjectUtils.isEmpty(floor.getId())) {
            if (existFloor != null) {
                throw new BusinessException("floor.add.name.exist");
            }
            floor.setCreateTime(LocalDateTime.now());
            floor.setUpdateTime(LocalDateTime.now());
            floorDao.insert(floor);
        } else {
            if (existFloor != null && !existFloor.getId().equals(floor.getId())) {
                throw new BusinessException("floor.update.name.exist");
            }
            floor.setUpdateTime(LocalDateTime.now());
            floorDao.updateById(floor);
        }
    }

    @Transactional
    @Override
    public void delete(String id) {
        Long roomCount = roomDao.selectCount(new LambdaQueryWrapper<Room>().eq(Room::getFloorId, id));
        if (roomCount != 0) {
            throw new BusinessException("floor.delete.fail.contain.room");
        }
        floorDao.deleteById(id);
    }

    @Override
    public List<FloorPageDto> floorList(String familyId) {
        return floorDao.selectFloorDto();
    }

    @Override
    public IPage<FloorPageDto> page(Integer pageNumber, Integer pageSize, String floorName, String familyId) {
        IPage<FloorPageDto> iPage = new Page<>(pageNumber == null ? 1 : pageNumber,
                pageSize == null ? 10 : pageSize);
        return floorDao.selectCustomPage(iPage, floorName, familyId);
    }
}
