### A Pluto.jl notebook ###
# v0.18.0

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local iv = try Base.loaded_modules[Base.PkgId(Base.UUID("6e696c72-6542-2067-7265-42206c756150"), "AbstractPlutoDingetjes")].Bonds.initial_value catch; b -> missing; end
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : iv(el)
        el
    end
end

# ╔═╡ cab5e5da-8609-11ec-2b2c-2d98fe66bb99
begin
    import Pkg
	ENV["JULIA_MARGO_LOAD_PYPLOT"] = "no thank you"
    Pkg.activate(mktempdir())
    Pkg.add([
        Pkg.PackageSpec(name="Plots", version="1"),
        Pkg.PackageSpec(name="ClimateMARGO", version=v"0.3.2"),
        Pkg.PackageSpec(name="PlutoUI", version="0.7"),
        Pkg.PackageSpec(name="HypertextLiteral", version="0.9"),
    ])
	
	using Plots
	using Plots.Colors
	using ClimateMARGO
	using ClimateMARGO.Models
	using ClimateMARGO.Optimization
	using ClimateMARGO.Diagnostics
	using PlutoUI
    using HypertextLiteral
	
	Plots.default(linewidth=5)
end;

# ╔═╡ cc8614a3-dd69-42d4-9954-44885bac93eb
md"## Exploring uncertainty in climate forcing, feedbacks, and ocean heat uptake.

*by Henri F. Drake*
"

# ╔═╡ 84ff8ba3-fd8a-4bc9-ab4e-7f763f98d34d
md"##### Anthropogenic forcing"

# ╔═╡ 8037ac4e-5c70-4aa7-9982-7442baaa83a0
md"##### The climate response"

# ╔═╡ 4575f6fd-d1ec-4fd1-bd56-268fab59a533


# ╔═╡ 7ea69497-8b83-45f9-93d3-bbce4c3c10b2
reveal_box = @bind reveal CheckBox(default=false);

# ╔═╡ 71975b7f-e8b7-4097-b573-8e383bb83868
if reveal
md"The analytical scalings are:

$\text{TCR}\propto \frac{a}{\lambda + \kappa}, \quad\quad\quad \text{ECS} \propto \frac{a}{\lambda}, \quad\quad\quad \tau = \frac{C_{D}}{\lambda}\,\frac{\lambda + \kappa}{\kappa}.$"
else
md"Reveal solution: $(reveal_box)"
end

# ╔═╡ 8b17a78f-f3d8-4777-becd-01de58974de3


# ╔═╡ 56e32b2b-8830-4f2c-97ea-7bc5820dca1b
ρ_slider = @bind ρ Slider(0.:0.5:3, default=3, show_value=true);

# ╔═╡ 7e63eaf5-6841-4f2d-9388-427d9905fd2e
do_optimize_box = @bind do_optimize CheckBox(default=false);

# ╔═╡ a442349e-f6ba-4841-93a6-d7ea7235371a
if reveal
md"#### Exercise 2: policy solutions
Explore the sensivity of ''optimal'' policy solutions. Check the box: $(do_optimize_box)
"
end

# ╔═╡ 053db221-7f7f-4358-915f-bcfb9f6b6783
if do_optimize
	md"*Note the emissions reductions (and carbon dioxide removal) and corresponding warming reductions above!*"
end

# ╔═╡ 2f4a79c4-5455-4b8d-9a85-1aac1cdad3f7
if do_optimize
	md"#### Exercise 3: Intergenerational (in)equity

You may have guessed the ''optimal'' level of warming depends strongly on economic preferences, e.g. how much the model values the welfare of future generations.
  
How does the ''optimal'' policy response change as we decrease the ''discount rate'' towards intergenerational equity?

 $(ρ_slider) % per year
	"
end

# ╔═╡ 42a58da0-bffc-4fd1-ab7b-0a90b0664e4e
begin
	if do_optimize
		last_year = 2800
	else
		last_year = 4000
	end
	end_year_slider = @bind end_year Slider(2100:50:last_year, default=2200, show_value=true);
end;

# ╔═╡ 97e66e74-7f38-4811-8d11-f69df3e5ce49
md"
#### Exercise 1: transient and equilibrium global warming
Lengthen the simulation's time horizon and graphically explore the scaling of the following emergent properties with the four key parameters above:

A) the Transient Climate Response (TCR), i.e. the warming in 2150 when forcing stabilizes

B) the Equilibrium Climate Sensivity (ECS), i.e. the warming when temperatures have equilibrated with

C) the timescale $\tau_{D}$ of the equilibration

$(end_year_slider)
"

# ╔═╡ 56b88523-aa8e-42d7-8637-17b0a0c6fd22


# ╔═╡ b72a5d5f-1806-4ae0-95e1-d3b1e4b845ce


# ╔═╡ 4fee292d-9cf1-40ec-b96d-0eacb0135cae
md"# Appendix"

# ╔═╡ 1a3b7318-d0a8-424a-96db-1deb03da716b
cmip5_std = Dict("a"=>0.9*log(2.), "λ"=>0.31, "κ"=>0.18, "Cd"=>62.)

# ╔═╡ 8742ea1c-54af-4a7d-8f41-1566a71c4d94
blob(el, color = "blue") = @htl("""<div style="
background: $(color);
padding: 1em 1em 1em 1em;
border-radius: 2em;
">$(el)</div>""");

# ╔═╡ 24d098eb-a548-4c80-935b-0e9bec229105
function default_parameters(years)::ClimateModelParameters
	result = deepcopy(ClimateMARGO.IO.included_configurations["default"])
	result.domain = years isa Domain ? years : Domain(step(years), first(years), last(years))
	result.economics.baseline_emissions = ramp_emissions(result.domain)
    result.economics.extra_CO₂ = zeros(size(result.economics.baseline_emissions))
	return result
end;

# ╔═╡ 226ae32f-36d4-4563-8af4-1aa9d16702c6
begin
	# Create default parameter values
	years = 2020:6.0:end_year;
	default_params = default_parameters(years);
	default_params.physics.a = 6.9*log(2.);
	phys = default_params.physics
end

# ╔═╡ c834b860-866d-4f21-b51a-4fa301d17348
a_slider = @bind a Slider(
	round(phys.a-2*cmip5_std["a"], digits=2)
	:round(4*cmip5_std["a"]/100., digits=2)
	:round(phys.a+2*cmip5_std["a"], digits=2),
	default=phys.a, show_value=true
);

# ╔═╡ 27c8bca8-55f9-4289-a839-cebbbf696169
λ_slider = @bind λ Slider(
	round(phys.B-2*cmip5_std["λ"], digits=2)
	:round(4*cmip5_std["λ"]/100., digits=2)
	:round(phys.B+2*cmip5_std["λ"], digits=2),
	default=phys.B, show_value=true
);

# ╔═╡ 672287f1-f1bd-4899-9d7e-29a6a5646f10
κ_slider = @bind κ Slider(
	round(phys.κ-2*cmip5_std["κ"], digits=2)
	:round(4*cmip5_std["κ"]/100., digits=2)
	:round(phys.κ+2*cmip5_std["κ"], digits=2),
	default=phys.κ, show_value=true
);

# ╔═╡ 58441503-2998-472e-b466-5d4c832f9042
Cd_slider = @bind Cd Slider(
	max(Int(round(phys.Cd-2*cmip5_std["Cd"], digits=0)), 20)
	:Int(round(4*cmip5_std["Cd"]/100., digits=0))
	:Int(round(phys.Cd+2*cmip5_std["Cd"], digits=0)),
	default=phys.Cd, show_value=true
);

# ╔═╡ 9c7d7e6c-d2d9-4754-b2e3-72c3b9e0ec06
let
	blob(
		@htl("""
	<h4>Energy Balance Model Parameters</h4>
	<h6>Defaults are CMIP5 multi-model mean; ranges are ±2σ.</h6>
	<style>
	.controltable thead th,
	.controltable tbody td {
	  text-align: center;
	}
	.controltable input[type=range] {
	  width: 10em;
	}
	</style>
	<table class="controltable">
	<thead>
	<th></th><th>Value</th>
	</thead>
	<tbody>
		<tr>

		<th>CO2 forcing parameter, a [W m⁻²]</th>
		<td>$(a_slider)</td>
		</tr>	

		
		<th>Feedback parameter, λ [W m⁻² K⁻¹]</th>
		<td>$(λ_slider)</td>
		</tr>

		<tr>
		<th> Heat uptake rate, κ [W m⁻² K⁻¹]</th>
		<td>$(κ_slider)</td>
		</tr>
		
		<tr>
		<th> Deep ocean heat capacity, C₀ [W yr m⁻² K⁻¹]</th>
		<td>$(Cd_slider)</td>
		</tr>
		
		
	</tbody>
	</table>
		"""),
		"#c0ecff33"
	)
end

# ╔═╡ 8c1ddae9-a9dd-4556-9027-4f701a064604
begin
	# Overwrite defaults with slider values
	params = deepcopy(default_params)
	params.economics.ρ = ρ/100. + params.economics.γ;
	params.economics.β = 0.003;
	params.physics.T0 = 1.0;
	params.physics.a = a;
	params.physics.B = λ;
	params.physics.κ = κ;
	params.physics.Cd = Cd;
	m = ClimateModel(params);
	max_deployment = Dict("mitigate"=>1., "remove"=>0.5, "geoeng"=>0., "adapt"=>0.)
	if do_optimize
		opt = optimize_controls!(
			m, obj_option="net_benefit", max_deployment=max_deployment
		);
	end
	m;
end

# ╔═╡ 1285f653-a4a8-4c5c-b395-2f3ffd24811d
begin
	p_emit = plot(t(m), effective_emissions(m), color=:grey, linewidth=3, alpha=0.5, label="baseline fossil growth")
	if do_optimize
		plot!(p_emit, t(m), effective_emissions(m, M=true, R=true), linewidth=5, color=:deepskyblue2, label="''optimal'' policy")
	end
	plot!(p_emit, t(m), 0. *t(m), linestyle=:dash, color=:black, alpha=0.3, linewidth = 2.5, label="")
	plot!(p_emit, ylim=(-5., 15.), xlim=(t(m)[1], t(m)[end]))
	plot!(p_emit, ylabel="emissions [ppm/year]", xlabel="year")
	plot!(p_emit, size=(700, 225), margins=2.75Plots.Measures.mm)
end

# ╔═╡ 13b0c090-ff52-4eca-98a5-1306f859c58f
begin
	p = plot(t(m), T(m), color=:grey, linewidth=3, alpha=0.5, label="baseline fossil growth")
	if do_optimize
		plot!(t(m), T(m, M=true, R=true), linewidth=5, color=:deepskyblue2, label="''optimal'' policy")
	end
	if minimum(T(m, M=true, R=true)) < 0.
		plot!(ylim=(-2, max(8, maximum(T(m, M=true, R=true)))), xlim=(t(m)[1], t(m)[end]))
	else
		plot!(ylim=(0, max(8, maximum(T(m, M=true, R=true)))), xlim=(t(m)[1], t(m)[end]))
	end
	plot!(ylabel="warming (relative to P-I)", xlabel="year")
	plot!(yticks=[-1., 0., 1., 1.5, 2., 2.5, 3., 4., 5., 6., 7., 8., 9, 10.])
	plot!(size=(700, 250), margins=2.75Plots.Measures.mm)
	plot!(legend=:topleft)
end

# ╔═╡ 10befe5b-9e7c-40a6-9079-1ab5a380888b
if do_optimize
	p_discount = plot(
		t(m),
		(1 .- (m.economics.ρ - m.economics.γ)).^((t(m) .- t(m)[1])) * 100., label=""
	)
	plot!(xlabel="year", ylabel="discount factor [%]", ylim = (0, 100))
end

# ╔═╡ Cell order:
# ╟─cc8614a3-dd69-42d4-9954-44885bac93eb
# ╟─84ff8ba3-fd8a-4bc9-ab4e-7f763f98d34d
# ╟─1285f653-a4a8-4c5c-b395-2f3ffd24811d
# ╟─8037ac4e-5c70-4aa7-9982-7442baaa83a0
# ╟─13b0c090-ff52-4eca-98a5-1306f859c58f
# ╟─9c7d7e6c-d2d9-4754-b2e3-72c3b9e0ec06
# ╟─97e66e74-7f38-4811-8d11-f69df3e5ce49
# ╟─4575f6fd-d1ec-4fd1-bd56-268fab59a533
# ╟─71975b7f-e8b7-4097-b573-8e383bb83868
# ╟─7ea69497-8b83-45f9-93d3-bbce4c3c10b2
# ╟─a442349e-f6ba-4841-93a6-d7ea7235371a
# ╟─053db221-7f7f-4358-915f-bcfb9f6b6783
# ╟─8b17a78f-f3d8-4777-becd-01de58974de3
# ╟─2f4a79c4-5455-4b8d-9a85-1aac1cdad3f7
# ╟─10befe5b-9e7c-40a6-9079-1ab5a380888b
# ╟─42a58da0-bffc-4fd1-ab7b-0a90b0664e4e
# ╟─56e32b2b-8830-4f2c-97ea-7bc5820dca1b
# ╟─7e63eaf5-6841-4f2d-9388-427d9905fd2e
# ╟─56b88523-aa8e-42d7-8637-17b0a0c6fd22
# ╟─b72a5d5f-1806-4ae0-95e1-d3b1e4b845ce
# ╟─4fee292d-9cf1-40ec-b96d-0eacb0135cae
# ╠═cab5e5da-8609-11ec-2b2c-2d98fe66bb99
# ╠═226ae32f-36d4-4563-8af4-1aa9d16702c6
# ╠═8c1ddae9-a9dd-4556-9027-4f701a064604
# ╠═1a3b7318-d0a8-424a-96db-1deb03da716b
# ╟─8742ea1c-54af-4a7d-8f41-1566a71c4d94
# ╟─c834b860-866d-4f21-b51a-4fa301d17348
# ╟─27c8bca8-55f9-4289-a839-cebbbf696169
# ╟─672287f1-f1bd-4899-9d7e-29a6a5646f10
# ╟─58441503-2998-472e-b466-5d4c832f9042
# ╟─24d098eb-a548-4c80-935b-0e9bec229105
