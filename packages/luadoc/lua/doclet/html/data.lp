<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

	    <%if doc.description.title == "" then%>
			<title><%=doc.description.package%></title>
		<%else%>
	    	<title><%=doc.description.title%></title>
	    <%end%>
	    <link rel="stylesheet" href="<%=luadoc.link('luadoc.css', 'files/data.lua')%>" type="text/css" />
		<!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/-->
	</head>

	<body>
		<div id="container">
			<div id="product">
				<div id="product_logo">
					<% if doc.description.url ~= "" then %>
						<a target="_blank" href="<%=doc.description.url%>">
					<% end %>
					<img src='<%="../img/logo.png"%>'/><br/></div>
					<% if doc.description.url ~= "" then %>
						</a>
					<% end %>
				<div id="product_name"><big><b></b></big></div>
				<div id="product_description"></div>
			</div> <!-- id="product" -->

			<div id="main">
				<div id="navigation">
					<%=luadoc.include("menu.lp", { doc = doc, mdata = true })%>
				</div> <!-- id="navigation" -->

				<div id="content">
					<%
					local function isProject(data)
						return (type(data.file[1]) == "string" and (data.file[1]:endswith(".tview") or data.file[1]:endswith(".qgs")))
					end

					doc.projectFiles = {}
					doc.dataFiles = {}

					if not options.nofiles and doc.mdata then
						for _, data in ipairs(doc.mdata) do
							if isProject(data) then
								table.insert(doc.projectFiles, data)
							else
								table.insert(doc.dataFiles, data)
							end
						end
					end
					%>
					<%local function buildIndex(mdata)%>
						<table class="file_list">
						<%for _, data in ipairs(mdata) do%>
							<tr>
								<td class="name"><a href = "#<%=data.name%>"><%=data.title%></a></td>
								<td class="summary"><%= data.shortsummary or "" %></td>
							</tr>
						<%end%>
						</table>
					<%end%>

					<%local function buildDirectory(mdata)%>
						<dl class="function">
							<%for _, data in ipairs(mdata) do%>
								<dt><h2 id = <%=data.name%>><%=data.title%></h2></dt>
								<%= httpLink(data.summary)%>
								<ul><span class="arg_data">
								<%if data.files == 1 then%>
									<li><b>File: </b>1
								<% else %>
									<li><b>Files: </b><%=data.files%>
								<% end %>

								<li><b>Extensions: </b><%=data.extensions%>

								<%if data.source then%>
									<li><b>Source: </b><%= httpLink(data.source)%></li>
								<%end%>

								<%if data.reference then%>
									<li><b>Reference: </b><%=data.reference%></li>
								<%end%>

								</ul></dd>
							<%end%>
						</dl>
					<%end%>

					<%local function buildAttributes(mdata, borderTop)%>
						<%if type(borderTop) == "number" then%>
							<%borderTop = "border-top: "..borderTop.."px"%>
							<%borderTop = "style=".."\""..borderTop.."\""%>
						<%else%>
							<%borderTop = ""%>
						<%end%>

						<dl class="function">
							<%for _, data in ipairs(mdata) do%>
								<% isproject = #data.file == 1 and (string.endswith(data.file[1], "tview") or string.endswith(data.file[1], "qgs")) %>

								<% if isproject then %>
									<%mlink = "<a href= \"../../data/"..data.name.."\">"..data.file[1].."</a>"%>
									<dt<%=borderTop%>><h2 id = <%=data.name%>><%=mlink%></h2></dt>

								<% else %>
									<dt<%=borderTop%>><h2 id = <%=data.name%>><%=data.title%></h2></dt>
								<% end %>

								<% if data.image then %>
									<% loc = "../../images/"..tostring(data.image) %>
									<center><img src=<% =loc %> ></center><br><br>
								<%end%>

								<%if data.summary then%>
									<%= httpLink(data.summary)%>
								<%else%>
									<font color="red"><%="undefined"%></font>
								<%end%>
								<dd>

								<ul><span class="arg_data">

								<% if not isproject then %>
									<%if #data.file == 1 then%>
										<li><b>File: </b>
									<% else %>
										<li><b>Files: </b>
									<% end %>
									<%for pos, f in ipairs(data.file) do%>
										<%mlink = "<a href= \"../../data/"..f.."\">"..f.."</a>"%>
										<%if pos<#data.file then%>
											<%=mlink..", "%>
										<%else%>
											<%=mlink%>
										<%end%>
									<%end%>
									</li>
								<% end %>

								<%if data.representation then%>
									<li><b>Representation: </b><%=data.representation%></li>
								<%end%>

								<%if data.quantity then%>
									<li><b>Quantity: </b><%=data.quantity%></li>
								<%end%>

								<%if data.bands then%>
									<li><b>Bands: </b><%=data.bands%></li>
								<%end%>

								<%if data.separator then%>
									<li><b>Separator: </b><%="\""..data.separator.."\""%></li>
								<%end%>

								<%if data.projection then%>
									<%if data.epsg > 0 and data.epsg < 100000 then%>
										<li><b>Projection: </b><a target = "_blank" href = <%="\"https://epsg.io/"..data.epsg.."\">"..data.projection%></a></li>
									<%else%>
										<li><b>Projection: </b><%=data.projection%></li>
									<%end%>
								<%end%>

								<%if data.origin then%>
									<%if not data.destination or data.origin == data.destination then%>
										<li><b>Connected file/layer: </b><%=data.origin%></li>
									<%else%>
										<li><b>Connected files/layers: </b><%=data.origin%> and <%=data.destination%></li>
									<%end%>
								<%end%>

								<%if data.origins then%>
									<li><b>Number of origins: </b><%=data.origins%></li>
								<%end%>

								<%if data.connections then%>
									<li><b>Number of connections: </b><%=data.connections%></li>
								<%end%>

								<%if data.source then%>
									<li><b>Source: </b><%= httpLink(data.source)%></li>
								<%end%>

								<%if data.reference then%>
									<li><b>Reference: </b><%=data.reference%></li>
								<%end%>

      							</span>
								<%if data.attributes and #data.attributes > 0 then%>
									<table class="arg_tab">
									<tr><th><%if data.bands then%>Band</th><th>Dummy<%else%>Attribute<%end%>
									</th><th>Type</th><th>Description</th></tr>
									<%if data.attributes[1] == "_incompatible_" then%>
										<tr>
										<td><font color="red">Incompatible sizes</font></td>
										<td><font color="red">Incompatible sizes</font></td>
										<td><font color="red">Incompatible sizes</font></td>
										</tr>
									<%else%>
										<% for j = 1, #data.attributes do %>
											<% if data.bands then %>
												<tr><td><%=data.attributes[j]%></td><td><%=data.dummy[j]%></td><td><%=tostring(data.types[j])%></td><td><%=data.description[j]%></td></tr>
											<% elseif type(data.attributes[j]) == "table" then %>
												<tr><td><%=table.concat(data.attributes[j], ", ")%></td><td><%=tostring(data.types[j])%></td><td><%=data.description[j]%></td></tr>
											
											<% else %>
												<tr><td><%=data.attributes[j]%></td><td><%=tostring(data.types[j])%></td><td><%=data.description[j]%></td></tr>
											<%end%>
										<%end%>
									<%end%>
									</table>
								<%end%>
								</ul>

								<%if data.layers then%>
									<table class="arg_tab">
									<tr><td><b>Layer</b></td><td><b>File</b></td><td><b>Description</b></td></tr>
									<% for j = 1,#data.layers do %>
									<tr><td><%="\""..data.layers[j].layer.."\""%></td><td><a href = "#<%=data.layers[j].file%>"><%=data.layers[j].file%></a></td><td><%=data.layers[j].description%></td></tr>
									<%end%>
									</table>
								<%end%>

								</dd>
							<%end%>
						</dl>
					<%end%>

					<!-- project -->
					<%if #doc.projectFiles > 0 then%>
						<h1>Projects</h1>
						<%buildAttributes(doc.projectFiles, 0)%>
					<%end%>
					<!-- /project -->
					<!-- data -->
					<%if #doc.dataFiles > 0 then%>
						<h1>Data</h1>
						<%buildIndex(doc.dataFiles)%>
					<%end%>
					<%if #doc.mdirectory > 0 then%>
						<h1>Directory</h1>
						<%buildIndex(doc.mdirectory)%>
					<%end%>
					<%if #doc.dataFiles > 0 then%>
						<%buildAttributes(doc.dataFiles)%>
					<%end%>
					<%if #doc.mdirectory > 0 then%>
						<%buildDirectory(doc.mdirectory)%>
					<%end%>

					<!-- /data -->
				</div>
				<!-- id="content" -->
			</div> <!-- id="main" -->

			<div id="about">
				<p>This webpage was automatically created using <a target="_blank" href="http://www.terrame.org">TerraME</a>.</p>
			</div> <!-- id="about" -->

		</div> <!-- id="container" -->	
	</body>
</html>

