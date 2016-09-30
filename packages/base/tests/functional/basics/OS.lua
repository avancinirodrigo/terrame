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
-- indirect, special, incidental, or consequential damages arising out of the use
-- of this library and its documentation.
--
-- Authors: Tiago Garcia de Senna Carneiro (tiago@dpi.inpe.br)
--          Pedro R. Andrade (pedro.andrade@inpe.br)
-------------------------------------------------------------------------------------------

return{
	currentDir = function(unitTest)
		local info = sessionInfo()
		local cur_dir = currentDir()
		Directory(info.path):setCurrentDir()
		unitTest:assertEquals(currentDir(), info.path)
		Directory(cur_dir):setCurrentDir()
	end,
	runCommand = function(unitTest)
		local d, e = runCommand("ls "..packageInfo().data)
		unitTest:assertEquals(#d, 29) -- 29 files
		unitTest:assertEquals(#e, 0)
	end,
	sessionInfo = function(unitTest)
		local s = sessionInfo()

		unitTest:assertEquals(s.mode, "debug")
		unitTest:assertEquals(s.version, packageInfo().version)
		unitTest:assertEquals(s.system == "windows", s.separator == "\\")
		unitTest:assertEquals(s.system == "linux" or s.system == "mac", s.separator == "/")

		local info = {
			mode = s.mode,
			round = s.round,
			silent = s.silent
		}

		local infoMock = {
			mode = "strict",
			round = 0.9,
			silent = true
		}

		s.mode = infoMock.mode
		s.round = infoMock.round
		s.silent = infoMock.silent

		unitTest:assertEquals(s.mode, infoMock.mode)
		unitTest:assertEquals(s.round, infoMock.round)
		unitTest:assertEquals(s.silent, infoMock.silent)

		s.mode = info.mode
		s.silent = info.silent
		s.round = info.round

		local count = 0
		local timer = Timer{
			Event{period = 1.0000001, action = function()
				count = count + 1
			end}
		}

		timer:run(5)
		unitTest:assertEquals(count, 5)

		s.round = 0.0000001
		count = 0
		timer = Timer{
			Event{period = 1.0000001, action = function()
				count = count + 1
			end}
		}

		timer:run(5)
		unitTest:assertEquals(count, 4)

		s.round = info.round
	end
}
