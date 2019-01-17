--[[ multiple analogue clock Edited by Etles_Team (2016)

Command to load and use this scripts in conkyrc before "TEXT"
assuming where this script you save (/path/scripts/lua/main.lua).
Example path :

lua_load ~/.conky/Conky-Name/scripts/lua/main.lua
lua_draw_hook_post conky_main
lua_draw_hook_pre conky_clock_rings

TEXT

]]

settings_table = {
{
name='time', arg='', max=100,
bg_colour=0xbb6600, bg_alpha=1,
fg_colour=0xffffff, fg_alpha=0,
x=100, y=100,
radius=30, thickness=100,
start_angle=0, end_angle=360
},
{
name='time', arg='', max=2200,
bg_colour=0x191815, bg_alpha=1,
fg_colour=0xffffff, fg_alpha=0,
x=100, y=100,
radius=20, thickness=100,
start_angle=0, end_angle=360
},
}

-- Use these settings to define the origin and extent of your clock.

clock_r=40

-- "clock_x" and "clock_y" are the coordinates of the centre of the clock, in pixels, from the top left of the Conky window.

clock_x=100
clock_y=100

-- Colour & alpha of the clock hands

clock_colourH=0xffff00
clock_colourM=0x00ffff
clock_colourS=0xff0000
clock_alpha=0

-- Do you want to show the seconds hand?

show_seconds=true

require 'cairo'

function rgb_to_r_g_b(colour,alpha)
	return ((colour / 0x10000) % 0x100) / 255., ((colour / 0x100) % 0x100) / 255., (colour % 0x100) / 255., alpha
end
--================================================================================================================
--Position horloge text
local init={
{text={"Hello World"},
nb=60,
formule='second',
police="URW Chancery L",
taille=14,
text_color=0x000000,
text_alpha=0,
text_color_current=0xbb6600,
text_alpha_current=1,
point_color=0xffffff,
point_alpha=0,
point_color_current=0x00ffff,
point_alpha_current=0,
hand_color=0xbb6600,
hand_alpha=1,
center_x=100,
center_y=100,
text_radius=33,
point_radius=44,
point_ray=0.5,
hand_gap=64,
hand_larg=8,
hand_length=68,
progressif=true
},
}
--=============================================================================================================================================
function conky_main()
if conky_window == nil then return end
local cs = cairo_xlib_surface_create(conky_window.display, conky_window.drawable, conky_window.visual, conky_window.width, conky_window.height)
local cr = cairo_create(cs)
local extents=cairo_text_extents_t:create()
tolua.takeownership(extents)
local h, min, sec=time()
local jour, jour_num, mois, nb_jour=date()
if tonumber(conky_parse('${updates}'))>1 then
for i in pairs(init) do
draw(cr, extents, init[i], h, min, sec, jour, jour_num, mois, nb_jour)
end
end
cairo_destroy(cr)
cairo_surface_destroy(cs)
cr=nil
collectgarbage()
end

function draw(cr, extents, value, h, min, sec, jour, jour_num, mois, nb_jour)
local function affichage(cr, extents, j, valeur, value, text, nb)
if value.progressif == nil then
value.progressif=false
end

if value.progressif==true and j<=valeur then
texte(value.police, value.taille, text, nb, value.text_radius, value.center_x, value.center_y, value.text_color_current, value.text_alpha_current, j, extents, cr)
point(nb, value.point_radius, value.center_x, value.center_y, value.point_color_current, value.point_alpha_current, j, cr, value.point_ray)
elseif value.progressif==false and j==valeur then
texte(value.police, value.taille, text, nb, value.text_radius, value.center_x, value.center_y, value.text_color_current, value.text_alpha_current, j, extents, cr)
point(nb, value.point_radius, value.center_x, value.center_y, value.point_color_current, value.point_alpha_current, j, cr, value.point_ray)
else
texte(value.police, value.taille, text, nb, value.text_radius, value.center_x, value.center_y, value.text_color, value.text_alpha, j, extents, cr)
point(nb, value.point_radius, value.center_x, value.center_y, value.point_color, value.point_alpha, j, cr, value.point_ray)
end
end

local pos
local nb=tonumber(table.getn(value.text))
cairo_select_font_face (cr, value.police, CAIRO_FONT_SLANT_NORMAL, CAIRO_FONT_WEIGHT_BOLD);
cairo_set_font_size (cr, value.taille)

-- Section Horloge
if value.formule=="hour" then
if value.decalage~=nil then
h=h+tonumber(value.decalage)
end

local text
nb=value.nb/3600
if nb==24 then h=tonumber(os.date("%H")) end
pos=hour(h, min, sec) ----
for i=1, nb do
local j=i-1
if value.hour_24==true then
if tonumber(os.date("%H"))<nb then
text=value.text[i]
else
text=value.text[i+12]
end
else
text=value.text[i]
end
affichage(cr, extents, j, h, value, text, nb)
end
elseif value.formule=="minute" then
pos=minute(min, sec)
for i=1, nb do
local j=i-1
local text=value.text[i]
affichage(cr, extents, j, min, value, text, nb)
end
elseif value.formule=="second" then
pos=sec
for i=1, nb do
local j=i-1
local text=value.text[i]
affichage(cr, extents, j, sec, value, text, nb)
end
-- Horloge avec personnalisée (non utilisé pour le moment)
else
pos=tonumber(conky_parse(value.formule))
for i=1, nb do
local j=i-1
local text=value.text[i]
if tonumber(text)==pos then
texte(value.police, value.taille, text, nb, value.text_radius, value.center_x, value.center_y, value.text_color_current, value.text_alpha_current, i, extents, cr)
point(nb, value.point_radius, value.center_x, value.center_y, value.point_color_current, value.point_alpha_current, i, cr, value.point_ray)
else
texte(value.police, value.taille, text, nb, value.text_radius, value.center_x, value.center_y, value.text_color, value.text_alpha, i, extents, cr)
point(nb, value.point_radius, value.center_x, value.center_y, value.point_color, value.point_alpha, i, cr, value.point_ray)
end
end
end
hand(pos, value.nb, value.text_radius, value.hand_length, value.hand_gap, value.hand_larg, value.center_x, value.center_y, value.hand_color, value.hand_alpha, cr)
end
--
function date()
local nb_jour
local jour=tonumber(os.date("%d"))
local jour_num=tonumber(os.date("%w"))
local mois=tonumber(os.date("%m"))
if mois==12 then
nb_jour=31
else
nb_jour=tonumber(conky_parse("${exec date --date '1 month' +%j}"))-tonumber(conky_parse("${exec date +%j}"))
end
return jour, jour_num, mois, nb_jour
end

function day(jour)
local hjour=(jour*24)+tonumber(os.date("%H"))
return hjour
end

function time()
local h=tonumber(os.date("%I"))
local min=tonumber(os.date("%M"))
local sec=tonumber(os.date("%S"))
return h, min, sec
end

function hour(h, min, sec)
local hs=(h*3600)+(min*60)+sec
return hs
end

function minute(min, sec)
local m=(min*60)+sec
return m
end

function rgb_to_r_g_b(col,alp)
return ((col / 0x10000) % 0x100) / 255, ((col / 0x100) % 0x100) / 255, (col % 0x100) / 255, alp
end

function texte(police, taille, text, nb, radius, center_x, center_y, color, alpha, i, extents, cr)
cairo_set_source_rgba (cr,rgb_to_r_g_b(color,alpha))
local point=(math.pi/180)*((360/nb)*(i))
local x=0+radius*(math.sin(point))
local y=0-radius*(math.cos(point))
cairo_text_extents(cr,text,extents)
local width=extents.width
local height=extents.height
cairo_move_to(cr,center_x+x-(width/2),center_y+y+(height/2))
cairo_show_text (cr, text)
cairo_stroke (cr)
end

function point(nb, radius, center_x, center_y, color, alpha, i, cr, ray)
cairo_set_source_rgba (cr,rgb_to_r_g_b(color,alpha))
local point=(math.pi/180)*((360/nb)*(i))
local x=0+radius*(math.sin(point))
local y=0-radius*(math.cos(point))
cairo_arc (cr,center_x+x,center_y+y,ray,0,2*math.pi)
cairo_stroke (cr)
end

function hand(pos, nb, radius, hand_length, hand_gap, largeur, center_x, center_y, color, alpha, cr)
cairo_set_source_rgba (cr,rgb_to_r_g_b(color,alpha))
local point=(math.pi/180)*((360/nb)*(pos))
local x_gap=0+hand_gap*(math.sin(point))
local y_gap=0-hand_gap*(math.cos(point))
local x=0+hand_length*(math.sin(point))
local y=0-hand_length*(math.cos(point))
cairo_move_to (cr,center_x+x_gap,center_y+y_gap)
cairo_line_to (cr,center_x+x,center_y+y)
cairo_set_line_width (cr,largeur)
cairo_set_line_cap (cr, CAIRO_LINE_CAP_ROUND)
cairo_stroke (cr)
end

--[[ CLOCK RINGS SECTION ]]

function draw_ring(cr,t,pt)
	local w,h=conky_window.width,conky_window.height

	local xc,yc,ring_r,ring_w,sa,ea=pt['x'],pt['y'],pt['radius'],pt['thickness'],pt['start_angle'],pt['end_angle']
	local bgc, bga, fgc, fga=pt['bg_colour'], pt['bg_alpha'], pt['fg_colour'], pt['fg_alpha']

	local angle_0=sa*(2*math.pi/360)-math.pi/2
	local angle_f=ea*(2*math.pi/360)-math.pi/2
	local t_arc=t*(angle_f-angle_0)

	-- Draw background ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_f)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(bgc,bga))
	cairo_set_line_width(cr,ring_w)
	cairo_stroke(cr)

	-- Draw indicator ring

	cairo_arc(cr,xc,yc,ring_r,angle_0,angle_0+t_arc)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(fgc,fga))
	cairo_stroke(cr)
end

function draw_clock_hands(cr,xc,yc)
	local secs,mins,hours,secs_arc,mins_arc,hours_arc
	local xh,yh,xm,ym,xs,ys

	secs=os.date("%S")
	mins=os.date("%M")
	hours=os.date("%I")

	secs_arc=(2*math.pi/60)*secs
	mins_arc=(2*math.pi/60)*mins+secs_arc/60
	hours_arc=(2*math.pi/12)*hours+mins_arc/12

	-- Draw hour hand

	xh=xc+0.7*clock_r*math.sin(hours_arc)
	yh=yc-0.7*clock_r*math.cos(hours_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xh,yh)

	cairo_set_line_cap(cr,CAIRO_LINE_CAP_ROUND)
	cairo_set_line_width(cr,4)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colourH,clock_alpha))
	cairo_stroke(cr)

	-- Draw minute hand

	xm=xc+clock_r*math.sin(mins_arc)
	ym=yc-clock_r*math.cos(mins_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xm,ym)

	cairo_set_line_width(cr,3)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colourM,clock_alpha))
	cairo_stroke(cr)

	-- Draw seconds hand

	if show_seconds then
	xs=xc+clock_r*math.sin(secs_arc)
	ys=yc-clock_r*math.cos(secs_arc)
	cairo_move_to(cr,xc,yc)
	cairo_line_to(cr,xs,ys)

	cairo_set_line_width(cr,2)
	cairo_set_source_rgba(cr,rgb_to_r_g_b(clock_colourS,clock_alpha))
		cairo_stroke(cr)
	end
end

function conky_clock_rings()
	local function setup_rings(cr,pt)
	local str=''
	local value=0

	str=string.format('${%s %s}',pt['name'],pt['arg'])
	str=conky_parse(str)
	value=tonumber(str)

	if value == nil then value = 0 end
	pct=value/pt['max']

	draw_ring(cr,pct,pt)
	end

	-- Check that Conky has been running for at least 5s

	if conky_window==nil then return end
	local cs=cairo_xlib_surface_create(conky_window.display,conky_window.drawable,conky_window.visual, conky_window.width,conky_window.height)

	local cr=cairo_create(cs)

	local updates=conky_parse('${updates}')
	update_num=tonumber(updates)

	if update_num>1 then
	for i in pairs(settings_table) do
	setup_rings(cr,settings_table[i])
	end
	end

	draw_clock_hands(cr,clock_x,clock_y)
end
--===================== Regards, Etles_Team ============================--
