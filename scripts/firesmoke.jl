# try
# 	using Plots
# 	println("Plots package found.")
# catch e
# 	println("Plots package not found. Installing...")
# 	using Pkg: Pkg
# 	Pkg.add("Plots")
# 	using Plots
# end

# x = collect(1:0.1:10)
# plot(x, @. sin(x) + cos(x); label = "sin(x) + cos(x)", title = "Firesmoke Plot", xlabel = "x", ylabel = "sin(x) + cos(x)")
# savefig("imgs/firesmoke_plot.png")


try
	using CairoMakie
	println("CairoMakie package found.")
catch
	println("CairoMakie package not found. Installing...")
	using Pkg: Pkg
	Pkg.add("CairoMakie")
	using CairoMakie
end

fig1 = begin
	x = 1:0.1:10
	fig = lines(x, x .^ 2; label = "Parabola",
		axis = (; xlabel = "x", ylabel = "y", title = "Title"),
		figure = (; size = (800, 600), fontsize = 22))
	axislegend(; position = :lt)
	save("./imgs/parabola.png", fig)
	fig
end


fig2 = begin
	x = y = -5:0.5:5
	z = x .^ 2 .+ y' .^ 2
	cmap = :plasma
	with_theme(colormap = cmap) do
		fig = Figure(fontsize = 22)
		ax3d = Axis3(fig[1, 1]; aspect = (1, 1, 1),
			perspectiveness = 0.5, azimuth = 2.19, elevation = 0.57)
		ax2d = Axis(fig[1, 2]; aspect = 1, xlabel = "x", ylabel = "y")
		pltobj = surface!(ax3d, x, y, z; transparency = true)
		heatmap!(ax2d, x, y, z; colormap = (cmap, 0.65))
		contour!(ax2d, x, y, z; linewidth = 2, levels = 12, color = :black)
		contour3d!(ax3d, x, y, z; linewidth = 4, levels = 12,
			transparency = true)
		Colorbar(fig[1, 3], pltobj; label = "z", labelrotation = pi)
		colsize!(fig.layout, 1, Aspect(1, 1.0))
		colsize!(fig.layout, 2, Aspect(1, 1.0))
		resize_to_layout!(fig)
		save("./imgs/simpleLayout.png", fig)
		fig
	end
end


fig3 = begin
	x = -2pi:0.1:2pi
	approx = fill(0.0, length(x))
	cmap = [:gold, :deepskyblue3, :orangered, "#e82051"]
	with_theme(palette = (; patchcolor = cgrad(cmap, alpha = 0.45))) do
		fig, axis, lineplot = lines(x, sin.(x); label = L"sin(x)", linewidth = 3, color = :black,
			axis = (; title = "Polynomial approximation of sin(x)",
				xgridstyle = :dash, ygridstyle = :dash,
				xticksize = 10, yticksize = 10, xtickalign = 1, ytickalign = 1,
				xticks = ((-π):(π/2):π, ["π", "-π/2", "0", "π/2", "π"]),
			))
		translate!(lineplot, 0, 0, 2) # move line to foreground
		band!(x, sin.(x), approx .+= x; label = L"n = 0")
		band!(x, sin.(x), approx .+= -x .^ 3 / 6; label = L"n = 1")
		band!(x, sin.(x), approx .+= x .^ 5 / 120; label = L"n = 2")
		band!(x, sin.(x), approx .+= -x .^ 7 / 5040; label = L"n = 3")
		limits!(-3.8, 3.8, -1.5, 1.5)
		axislegend(; position = :ct, backgroundcolor = (:white, 0.75), framecolor = :orange)
		save("./imgs/approxsin.png", fig, size = (800, 600))
		fig
	end
end
