#!/usr/bin/env wish

proc draw_rect { can x y r width height colour tag } {
    $can create oval $x $y [expr $x + $r] [expr $y + $r] -fill $colour -outline $colour
    $can create oval [expr $width-$r] $y $width [expr $y + $r] -fill $colour -outline $colour
    $can create oval $x [expr $height-$r] [expr $x+$r] $height -fill $colour -outline $colour
    $can create oval [expr $width-$r] [expr $height-$r] [expr $width] $height -fill $colour -outline $colour
    $can create rectangle [expr $x + ($r/2.0)] $y [expr $width-($r/2.0)] $height -fill $colour -outline $colour
    $can create rectangle $x [expr $y + ($r/2.0)] $width [expr $height-($r/2.0)] -fill $colour -outline $colour
}

proc draw_circle {can x y r} {
    set x0 [expr {$x - $r}]
    set y0 [expr {$y - $r}]
    set x1 [expr {$x + $r}]
    set y1 [expr {$y + $r}]
    $can create oval $x0 $y0 $x1 $y1 -outline #777 -fill #777 -tags dot
}

proc draw_1 {can} {
    draw_circle $can 125 100 25
}

proc draw_2 {can} {
    draw_circle $can 180 45 25
    draw_circle $can 70 155 25
}

proc draw_3 {can} {
    draw_1 $can
    draw_2 $can
}

proc draw_4 {can} {
    draw_2 $can
    draw_circle $can 180 155 25
    draw_circle $can 70 45 25
}

proc draw_5 {can} {
    draw_4 $can
    draw_1 $can
}

proc draw_6 {can} {
    draw_4 $can
    draw_circle $can 180 100 25
    draw_circle $can 70 100 25
}

proc draw_rand {can} {
    $can delete dot
    set num [expr { int(6*rand()+1) }]
    "draw_$num" $can
}

proc press {} {
    global .can
    for {set i 0} {$i < 10} {incr i} {
        draw_rand .can
        sleep 60
    }
}

proc sleep {time} {
    after $time set __dice__ 1
    vwait __dice__
}

frame .fr

label .label -text {Roll the dice!}

canvas .can
draw_rect .can 25 0 30 225 200 white dice
draw_1 .can

pack .label .can -expand yes -fill both

button .btn -text {Roll} -command press
pack .btn

wm title . Dice
wm geometry . 250x250+300+300
