package pro.dengyi.myhome.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;
import pro.dengyi.myhome.dao.FloorDao;
import pro.dengyi.myhome.exception.BusinessException;
import pro.dengyi.myhome.model.Floor;
import pro.dengyi.myhome.model.dto.FloorDto;
import pro.dengyi.myhome.service.FloorService;

import java.util.List;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
@Service
public class FloorServiceImpl implements FloorService {
    @Autowired
    private FloorDao floorDao;

    @Transactional
    @Override
    public void addUpdate(Floor floor) {
        if (ObjectUtils.isEmpty(floor.getId())) {
            //校验楼层名
            Floor floorSaved = floorDao.selectOne(new LambdaQueryWrapper<Floor>().eq(Floor::getName, floor.getName()));
            if (floorSaved != null) {
                throw new BusinessException(13001, "同名楼层已存在");
            }
            floorDao.insert(floor);
        } else {
            floorDao.updateById(floor);
        }

    }

    @Transactional
    @Override
    public void delete(String id) {
        floorDao.deleteById(id);
    }

    @Override
    public List<FloorDto> floorList() {
        return floorDao.selectFloorDto();
    }

    @Override
    public IPage<FloorDto> page(Integer pageNumber, Integer pageSize, String floorName) {
        IPage<FloorDto> iPage = new Page<>(pageNumber == null ? 1 : pageNumber, pageSize == null ? 10 : pageSize);
        return floorDao.selectCustomPage(iPage, floorName);
    }
}
