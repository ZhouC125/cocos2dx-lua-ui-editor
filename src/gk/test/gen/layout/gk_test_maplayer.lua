return {
	debugDrawMask = "DEBUGDRAW_ALL",
	height = "$fill",
	id = "mapLayer1",
	type = "MapLayer",
	width = "$fill",
	gravity = {
	   x = 0,
	   y = 0},
	children = {	   {
	      _lock = 0,
	      height = 6000,
	      id = "layerColor1",
	      ignoreAnchor = 1,
	      scaleX = "$minScale",
	      scaleY = "$minScale",
	      type = "cc.LayerColor",
	      width = 10000,
	      x = 640,
	      y = -1384,
	      color = {
	         a = 255,
	         b = 153,
	         g = 153,
	         r = 153},
	      scaleXY = {
	         x = "$minScale",
	         y = "$scaleY"},
	      children = {	         {
	            file = "map1.png",
	            id = "sprite1",
	            scaleX = 25,
	            scaleY = 25,
	            type = "cc.Sprite",
	            x = 5000,
	            y = 3000,
	            children = {	               {
	                  borderWidth = 0.1,
	                  id = "drawPolygon1",
	                  lineWidth = 1,
	                  pointsNum = 15,
	                  type = "DrawPolygon",
	                  x = 206.5,
	                  y = 153,
	                  fillColor = {
	                     a = 0,
	                     b = 0.5,
	                     g = 0,
	                     r = 0},
	                  points = {	                     {
	                        x = -12.5,
	                        y = 73.5},
	                     {
	                        x = 125,
	                        y = 106.5},
	                     {
	                        x = 130.5,
	                        y = 104.5},
	                     {
	                        x = 132.5,
	                        y = 99.5},
	                     {
	                        x = 134,
	                        y = 94.5},
	                     {
	                        x = 138,
	                        y = 80},
	                     {
	                        x = 150.5,
	                        y = 55},
	                     {
	                        x = 156.5,
	                        y = 35},
	                     {
	                        x = 161.5,
	                        y = 10.5},
	                     {
	                        x = 184,
	                        y = -9.5},
	                     {
	                        x = 186.5,
	                        y = -15},
	                     {
	                        x = 187,
	                        y = -24},
	                     {
	                        x = 179,
	                        y = -90},
	                     {
	                        x = -157.5,
	                        y = -87.5},
	                     {
	                        x = -176,
	                        y = 80}}},
	               {
	                  id = "sprite2",
	                  scaleX = 0.08,
	                  scaleY = 0.02,
	                  type = "cc.Sprite",
	                  x = -12.5,
	                  y = 73.5,
	                  physicsBody = {
	                     _isPhysics = true,
	                     id = "body1",
	                     type = "cc.PhysicsBody",
	                     velocity = {
	                        x = 0,
	                        y = 0},
	                     shapes = {	                        {
	                           _isPhysics = true,
	                           density = 0,
	                           friction = 0.8,
	                           id = "shapeBox1",
	                           radius = 0,
	                           restitution = 0.8,
	                           type = "cc.PhysicsShapeBox",
	                           offset = {
	                              x = 0,
	                              y = 0},
	                           size = {
	                              height = 50,
	                              width = 60}}}}}}}}}}}