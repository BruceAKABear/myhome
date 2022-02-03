package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.RoomDao;
import pro.dengyi.myhome.model.Room;
import pro.dengyi.myhome.model.dto.RoomDto;
import pro.dengyi.myhome.service.RoomService;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Service
public class RoomServiceImpl implements RoomService {
    @Autowired
    private RoomDao roomDao;

    @Transactional
    @Override
    public void addUpdate(Room room) {
        if (ObjectUtils.isEmpty(room.getId())) {
            roomDao.insert(room);
        } else {
            roomDao.updateById(room);
        }
    }

    @Transactional
    @Override
    public void delete(String id) {
        roomDao.deleteById(id);
    }

    @Override
    public IPage<RoomDto> page(Integer pageNumber, Integer pageSize, String floorId) {
        IPage<RoomDto> page = new Page<>(pageNumber == null ? 1 : pageNumber, pageSize == null ? 10 : pageSize);
        return roomDao.selectCustomPage(page, floorId);
    }
}
