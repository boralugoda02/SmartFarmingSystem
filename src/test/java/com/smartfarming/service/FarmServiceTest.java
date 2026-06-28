package com.smartfarming.service;

import com.smartfarming.model.Farm;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import static org.junit.jupiter.api.Assertions.*;

import java.util.List;

public class FarmServiceTest {
    private FarmService farmService;

    @BeforeEach
    public void setUp() {
        // 💡 හැම ටෙස්ට් කේස් එකක්ම රන් වෙන්න කලින් FarmService එකක් අලුතින් සාදා ගනී
        farmService = new FarmService();
    }

    @Test
    public void testGetAllFarms() {
        // 💡 ඩේටාබේස් එකෙන් ෆාම් ලිස්ට් එක සාර්ථකව ලැබෙනවාද කියා ටෙස්ට් කිරීම
        List<Farm> farms = farmService.getAllFarms();

        // ලිස්ට් එක null නොවිය යුතු බවට තහවුරු කරගන්නවා
        assertNotNull(farms, "Farm list should not be null");
        System.out.println("Test Passed: Successfully retrieved " + farms.size() + " farms from database.");
    }
}