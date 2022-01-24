package pro.dengyi.myhome.service;

import pro.dengyi.myhome.model.Room;

/**
 * @author dengyi (email:dengyi@dengyi.pro)
 * @date 2022-01-23
 */
public interface RoomService {
    void addUpdate(Room room);

    void delete(String id);
}
