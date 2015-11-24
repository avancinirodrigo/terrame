-------------------------------------------------------------------------------------------
-- TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
-- Copyright (C) 2001-2014 INPE and TerraLAB/UFOP.
--
-- This code is part of the TerraME framework.
-- This framework is free software; you can redistribute it and/or
-- modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
--
-- You should have received a copy of the GNU Lesser General Public
-- License along with this library.
--
-- The authors reassure the license terms regarding the warranties.
-- They specifically disclaim any warranties, including, but not limited to,
-- the implied warranties of merchantability and fitness for a particular purpose.
-- The framework provided hereunder is on an "as is" basis, and the authors have no
-- obligation to provide maintenance, support, updates, enhancements, or modifications.
-- In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
-- indirect, special, incidental, or caonsequential damages arising out of the use
-- of this library and its documentation.
--
-- Authors: Pedro R. Andrade
-------------------------------------------------------------------------------------------

return{
	Agent = function(unitTest)
		local world = Agent{
			count = 0,
			mcount = function(self)
				return self.count + 1
			end
		}

		local c1 = Chart{target = world}

		local c2 = Chart{
			target = world,
			select = "mcount"
		}

		unitTest:assertType(c1, "Chart")

		world:notify(0)
		world.count = world.count + 5
		world:notify(1)
		world.count = world.count + 5
		world:notify(2)
		--unitTest:clear()

		local t = Timer{
			Event{action = function(e)
				world.count = world.count + 1
				world:notify(e)
			end}
		}

		local ts = TextScreen{target = world}
		LogFile{target = world}
		local vt = VisualTable{target = world}

		t:execute(15)

		local mytable = CSVread("result.csv")
		unitTest:assertEquals(#mytable, 15)
		unitTest:assertFile("result.csv")

		unitTest:assertSnapshot(c1, "chart_agent.bmp", 0.01)
		unitTest:assertSnapshot(c2, "chart_agent_select.bmp", 0.01)
		unitTest:assertSnapshot(ts, "textscreen_agent_select.bmp", 0.01)
		unitTest:assertSnapshot(vt, "agent_visualtable.bmp", 0.059)
		
		unitTest:clear()

		local world = Agent{
			probability = 0,
			mx = 0
		}

		local c3 = Chart{
			target = world,
			xAxis = "probability"
		}
		unitTest:assertType(c3, "Chart")

		local t = Timer{
			Event{action = function(e)
				if e:getTime() < 100 then
					world.probability = world.probability + 0.01
				else
					world.probability = world.probability - 0.01
				end
				world.mx = world.mx + world.probability ^ 2
				world:notify()
			end}
		}

		t:execute(200)

		unitTest:assertSnapshot(c3, "chart_agent_xaxis.bmp", 0.02)
	end
}
