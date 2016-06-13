-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2016 INPE and TerraLAB/UFOP -- www.terrame.org

-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.

-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.

-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or consequential damages arising out of the use
-- of this software and its documentation.
--
-------------------------------------------------------------------------------------------

return{
	assertSnapshot = function(unitTest)
		local c = Cell{value = 1}

		local ch = Chart{target = c}

		c:notify(1)
		c:notify(2)
		c:notify(3)

		unitTest:assertSnapshot(ch, "chart_snapshot_test.bmp", 0.01)
	end,
    clear = function(unitTest)
        local u = UnitTest{sleep = 1}
        local cell = Cell{value = 1}
        Chart{target = cell}

        local t1 = os.time()
        u:clear()
        local t2 = os.time()
        unitTest:assert(t2 - t1 >= 1)
    end
}

