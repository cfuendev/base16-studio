def hexToHsl(hex)
	# convert HEX to RGB
	r g b = hex.match(/\w\w/g).map { |c| c.to_i(16) }
	# normalize the values from 0-255 to 0-1
	r /= 255.0
	g /= 255.0
	b /= 255.0

	# find the maximum and minimum values of r, g, b
	max = [r, g, b].max()
	min = [r, g, b].min()

	# calculate the luminosity
	l = (max + min) / 2

	# if the color is a shade of gray, return it as is
	if max == min
		return [0, 0, l]
	end

	# calculate the saturation
	d = max - min
	s = l > 0.5 ? d / (2 - max - min) : d / (max + min)

	# calculate the hue
	h = case max
		when r
			(g - b) / d + (g < b ? 6 : 0)
		when g
			(b - r) / d + 2
		when b
			(r - g) / d + 4
	end
	h /= 6
	[h, s, l]
end