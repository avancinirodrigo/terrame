/************************************************************************************
TerraME - a software platform for multiple scale spatially-explicit dynamic modeling.
Copyright (C) 2001-2017 INPE and TerraLAB/UFOP -- www.terrame.org

This code is part of the TerraME framework.
This framework is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

You should have received a copy of the GNU Lesser General Public
License along with this library.

The authors reassure the license terms regarding the warranties.
They specifically disclaim any warranties, including, but not limited to,
the implied warranties of merchantability and fitness for a particular purpose.
The framework provided hereunder is on an "as is" basis, and the authors have no
obligation to provide maintenance, support, updates, enhancements, or modifications.
In no event shall INPE and TerraLAB / UFOP be held liable to any party for direct,
indirect, special, incidental, or consequential damages arising out of the use
of this software and its documentation.
*************************************************************************************/

#ifndef QGIS_H
#define QGIS_H

#include "Config.h"
#include "QGisProject.h"
#include "QGisLayer.h"

namespace terrame
{
	namespace qgis
	{
		class TERRAME_QGIS_DLL_EXPORT QGis
		{
		public:
			static QGis& getInstance();
			terrame::qgis::QGisProject read(const std::string& qgsfile);
			void write(const terrame::qgis::QGisProject& qgp);
			void setPostgisRole(const std::string& user = "",
								const std::string& password = "");

		private:
			QGis(){}
			QGis(const QGis&);
			QGis& operator=(const QGis&);
			~QGis(){}

			std::string user;
			std::string password;
		};
	} // namespace qgis
} // namespace terrame

#endif
