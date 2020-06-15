#!/usr/bin/env wish

proc draw_rect {can} {
    $can create rect 0 0 200 200 -outline white -fill white
}

proc draw_circle {can x y r} {
    set x0 [expr {$x - $r}]
    set y0 [expr {$y - $r}]
    set x1 [expr {$x + $r}]
    set y1 [expr {$y + $r}]
    $can create oval $x0 $y0 $x1 $y1 -outline #777 -fill #777 -tags dot
}

proc draw_1 {can} {
    draw_circle $can 100 100 25
}

proc draw_2 {can} {
    draw_circle $can 155 45 25
    draw_circle $can 45 155 25
}

proc draw_3 {can} {
    draw_1 $can
    draw_2 $can
}

proc draw_4 {can} {
    draw_2 $can
    draw_circle $can 155 155 25
    draw_circle $can 45 45 25
}

proc draw_5 {can} {
    draw_4 $can
    draw_1 $can
}

proc draw_6 {can} {
    draw_4 $can
    draw_circle $can 155 100 25
    draw_circle $can 45 100 25
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
    after $time set _dice_ 1
    vwait _dice_
}

frame .fr

label .label -text {Roll the dice!}

canvas .can
draw_rect .can
draw_2 .can

pack .label .can -expand yes -fill both

button .btn -text {Roll} -command press
pack .btn

wm title . Dice
wm geometry . 350x250+300+300
