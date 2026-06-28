package com.smartfarming.service;

import com.smartfarming.dao.FarmDAO;
import com.smartfarming.model.Farm;
import java.util.List;

public class FarmService {
    private FarmDAO farmDAO;

    public FarmService() {
        this.farmDAO = new FarmDAO();
    }

    // 1. Add Farm
    public boolean addFarm(Farm farm) {
        if (farm.getFarmName() == null || farm.getFarmName().trim().isEmpty() ||
                farm.getLocation() == null || farm.getLocation().trim().isEmpty()) {
            return false;
        }
        return farmDAO.addFarm(farm);
    }

    // 2. Get All Farms
    public List<Farm> getAllFarms() {
        return farmDAO.getAllFarms();
    }

    // 3. Get Farm by ID
    public Farm getFarmById(int farmId) {
        return farmDAO.getFarmById(farmId);
    }

    // 4. Update Farm
    public boolean updateFarm(Farm farm) {
        return farmDAO.updateFarm(farm);
    }

    // 5. Delete Farm
    public boolean deleteFarm(int farmId) {
        return farmDAO.deleteFarm(farmId);
    }
}