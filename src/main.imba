import convert from 'color-convert';
import * as monaco from 'monaco-editor';

global css @root bg:black/60 c:white

# RGB, HSL, LCH and HEX 

# https://dev.to/bhaskar95460442/create-an-html-color-picker-using-javascript-3obm

tag preview
	def awaken
		console.log "epa"

		<self>
			<div#mona-container[m:0 rd:5px h:300px w:312.8px of:clip bgc:white c:black]>

	def mount
		# create monaco
		console.log "hiiii"
		monaco.editor.create(document.getElementById('mona-container'), {
			value: '',
			language: 'javascript',
		})

tag palette
	def paletteColorClick color
		data.color = data.colors.indexOf(color)

	css d:hflex w:auto
	css div h:30px w:19.55px 
	css div > div
		h:30px w:19.55px ead:120ms eaf:cubic-out
	css div@hover > div y:5px
	css div@active > div y:10px filter:brightness(200%)
	<self>
		for color in data.colors
			<div @click=paletteColorClick(color)>
				<div[bgc:{'#'+color}]>

tag picker
	mouseIsDown = false
	marker = {x: null, y: null}
	css .Marker
		bgi:url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='1em' height='1em' viewBox='0 0 256 256'%3E%3Cpath fill='white' d='M128 236a108 108 0 1 1 108-108a108.1 108.1 0 0 1-108 108Zm0-192a84 84 0 1 0 84 84a84.1 84.1 0 0 0-84-84Z'/%3E%3C/svg%3E");
		w:24px h:24px bgs:cover bgr:no-repeat pos:absolute pointer-events:none
	css rd:5px p:16px bw:1px bs:dashed bc:black
	<self>
		<canvas[rd:5px] id="color_canvas" @mousemove=handleCanvasMousemove(e)/>
		<div.Marker[t:{marker.y}px l:{marker.x}px]>
		<div[bgc:{'#'+data.colors[data.color]} w:30px h:19.55px ead:120ms eaf:cubic-out]>

	def handleCanvasMousemove(e)
		if mouseIsDown
			const x = e.clientX
			const y = e.clientY
			marker.x = x - 11
			marker.y = y - 11
			const canvas = self.children[0]
			const bcr = canvas.getBoundingClientRect();
			let pixelRGB = canvas.getContext('2d').getImageData(x - bcr.x,y - bcr.y,1,1)['data']
			data.colors[data.color] = convert.rgb.hex(
				pixelRGB[0], pixelRGB[1], pixelRGB[2]
			)

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
		gradientH.addColorStop(1, (data.color ? data.colors[data.color] : color))
		ctx.fillStyle = gradientH
		ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height)

		# create a vertical gradient
		gradientV = ctx.createLinearGradient(0, 0, 0, ctx.canvas.height)
		gradientV.addColorStop(0, 'rgba(0,0,0,0)')
		gradientV.addColorStop(1, 'black')
		ctx.fillStyle = gradientV
		ctx.fillRect(0, 0, ctx.canvas.width, ctx.canvas.height)

		canvas.onmousedown = do
			mouseIsDown = true
		canvas.onmouseup = do
			mouseIsDown = false

	
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
			const hsl = convert.hex.hsl(data.colors[data.color])
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
		color: 0
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