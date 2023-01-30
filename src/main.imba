import Prism from 'prismjs';
import convert from 'color-convert';

global css @root bg:black/60 c:white

# RGB, HSL, LCH and HEX 

# https://dev.to/bhaskar95460442/create-an-html-color-picker-using-javascript-3obm

tag preview
	<self>
		<pre[m:0 h:300px w:312.8px bgc:white c:black]> "codigo"

tag palette
	def paletteColorClick color
		data.color = color

	css d:hflex w:auto
	css div
		h:30px w:19.55px ead:120ms eaf:cubic-out
		y@hover:5px
		y@active:10px filter@active:brightness(200%)
	<self>
		for color in data.colors
			<div[bgc:{'#'+color}] @click=paletteColorClick(color)>

tag picker
	css p:16px bw:1px bs:dashed bc:black
	<self>
		<canvas id="color_canvas"/>
		<div[bgc:{'#'+data.color} w:30px h:19.55px ead:120ms eaf:cubic-out]>

	def mount
		# get the canvas element from the component
		canvas = self.children[0]
		# set the width and height of the canvas
		canvas.width = 156.39
		canvas.height = 150
		# get the 2D context for the canvas
		ctx = canvas.getContext("2d")
		
		color = 'rgba(0,0,255,1)'
		# create a horizontal gradient
		gradientH = ctx.createLinearGradient(0, 0, ctx.canvas.width, 0)
		gradientH.addColorStop(0, 'rgba(255,255,255,1)')
		gradientH.addColorStop(1, (data.color ? data.color : color))
		ctx.fillStyle = gradientH
		ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height)

		# create a vertical gradient
		gradientV = ctx.createLinearGradient(0, 0, 0, ctx.canvas.height)
		gradientV.addColorStop(0, 'rgba(0,0,0,0)')
		gradientV.addColorStop(1, 'black')
		ctx.fillStyle = gradientV
		ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height)
	
	def rendered
		# if component has already mounted (not first render, only update render)
		if self.mounted?
			# get the canvas element from the component
			canvas = self.children[0]
			# get the 2D context for the canvas
			ctx = canvas.getContext("2d")

			# create a new horizontal gradient
			gradientH = ctx.createLinearGradient(0, 0, ctx.canvas.width, 0)
			gradientH.addColorStop(0, '#fff')
			const hsl = convert.hex.hsl(data.color)
			gradientH.addColorStop(1, '#'+convert.hsl.hex([hsl[0],100,50]))
			ctx.fillStyle = gradientH
			ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height)

			# create a vertical gradient
			gradientV = ctx.createLinearGradient(0, 0, 0, ctx.canvas.height)
			gradientV.addColorStop(0, 'rgba(0,0,0,0)')
			gradientV.addColorStop(1, 'rgba(0,0,0,1)')
			ctx.fillStyle = gradientV
			ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height)
			


tag piece
	data = {
		colors: [
			"262626", # ----
			"3a3a3a", # ---
			"4e4e4e", # --
			"8a8a8a", # -
			"949494", # +
			"dab997", # ++
			"d5c4a1", # +++
			"ebdbb2", # ++++
			"d75f5f", # red
			"ff8700", # orange
			"ffaf00", # yellow
			"afaf00", # green
			"85ad85", # aqua/cyan
			"83adad", # blue
			"d485ad", # purple
			"d65d0e" # brown
		],
		color: ""
	}

	<self[d:hflex]>
		<div>
			<preview data=data>
			<palette[mt:16px] data=data>
		<div [ml:16px]>
			<picker data=data>

tag app

	# inline styles with square brackets
	<self[max-width:1280px m:0 auto p:2rem ta:center]>
		<piece>

imba.mount <app>