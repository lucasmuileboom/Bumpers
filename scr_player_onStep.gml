// Input
left = keyboard_check(ord('A'));
right = keyboard_check(ord('D'));
up = keyboard_check(ord('W'));
down = keyboard_check(ord('S'));

xaxis = right - left;
yaxis = down - up;

moving = (yaxis != 0);

if(moving){
    dir = yaxis;
    
    // Turning
    if(xaxis != 0){
        if(yaxis == -1){ // Forward
            if(left){
                image_angle += turnSpeed;
        } else if(right){
                image_angle -= turnSpeed;
            }
        } else if(yaxis == 1) { // Backwards
            if(left){   
                image_angle += turnReverseSpeed;   
            } else if(right){
                image_angle -= turnReverseSpeed;
            }
        }
    }
    
    // Moving
    if(yaxis == -1){
            if(len < maxSpeed){
            len += accelerationSpeed;
        } else if(len > maxSpeed){
            len = maxSpeed;
        }
    } else if(yaxis == 1){
        if(len > -maxReverseSpeed){
            len -= accelerationReverseSpeed;
        } else if(len < -maxReverseSpeed) {
            len = -maxReverseSpeed;
        }
    }
 } else { // When moving
    if(dir == -1){ // When moving forwards
        if(len > 0){
            len -= frictionSpeed;
        } else if(len <= 0){
            len = 0;
        }
    } else if (dir == 1){ // When moving backwards
        if(len <0){
            len += frictionSpeed;
        } else if(len >= 0){
            len = 0;
        }
    }
}

// Calculate where to move
hspd = lengthdir_x(len, image_angle);
vspd = lengthdir_y(len, image_angle);

// Move the player
x += hspd;
y += vspd;

// Shooting
if keyboard_check_pressed(ord('Q')){
    bullet = instance_create(x, y, obj_bullet);
    bullet.direction = image_angle;
    bullet.image_angle = image_angle;
    bullet.speed = 15;
}

// Death
if place_meeting(x, y, obj_bullet2){
    liv -= 1;
    room_goto(rm_winner_player2);
    if(liv <= 0){
        instance_destroy();
    }
}
