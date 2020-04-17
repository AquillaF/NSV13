/*

Vector class written by Monster860, modified by Kmc2000 under Qwerty's guidance.

This uses operator overloading

Special thanks to qwertyquerty for explaining and dictating a lot of this! (I've mostly translated his pseudocode into readable byond code)

*/

/datum/vector2d
	var/x
	var/y

/*
Constructor for vector2d objects, taking a simple X,Y coordinate.
*/

/datum/vector2d/New(x = 0, y = 0)
	src.x = x
	src.y = y
	..()

/*
Method to set our position directly
*/

/datum/vector2d/proc/_set(x,y)
	src.x = x
	src.y = y

/*
Method to turn this vector counter clockwise by a desired angle
*/

/datum/vector2d/proc/rotate(angle)
	var/s = sin(angle)
	var/c = cos(angle)
	var/newx = c*x + s*y
	var/newy = -s*x + c*y
	x = newx
	y = newy
	return src
/*
A method to make a copy of this vector
@return a new vector2d with the same stats as this one
*/

/datum/vector2d/proc/clone()
	return new /datum/vector2d(x,y)

/*
Method to overload the + operator to add a vector to another vector
@return a new vector with the desired x,y after addition
*/

/datum/vector2d/proc/operator+(datum/vector2d/b)
	if(isnum(b))
		return new /datum/vector2d(x+b, y+b)
	else if(istype(b, /datum/vector2d))
		return new /datum/vector2d(x+b.x, y+b.y)

/*
Method to overload the += operator to add the X,Y coordinates to our own ones, without making a new vector2d
*/

/datum/vector2d/proc/operator+=(datum/vector2d/b)
	if(isnum(b))
		x += b
		y += b
	else if(istype(b, /datum/vector2d))
		x += b.x
		y += b.y

/*
Method to overload the - operator to subtract a vector from this one.
@return a new vector with the desired X,Y after operation performed
*/

/datum/vector2d/proc/operator-(datum/vector2d/b)
	if(!b)
		return new /datum/vector2d(-x,-y)
	else if(isnum(b))
		return new /datum/vector2d(x-b, y-b)
	else if(istype(b, /datum/vector2d))
		return new /datum/vector2d(x-b.x, y-b.y)
/*
Method to overload the += operator to subtract the X,Y coordinates to our own ones, without making a new vector2d
*/

/datum/vector2d/proc/operator-=(datum/vector2d/b)
	if(isnum(b))
		x -= b
		y -= b
	else if(istype(b, /datum/vector2d))
		x -= b.x
		y -= b.y

/*
Method to overload the * operator to multiply this vector by another one
@return a vector2d object with the required calculations done.
*/


/datum/vector2d/proc/operator*(datum/vector2d/b)
	if(isnum(b))
		return new /datum/vector2d(x*b, y*b)
	else if(istype(b, /datum/vector2d))
		return new /datum/vector2d(x*b.x, y*b.y)

/*
Method to overload the / operator to multiply this vector by another one
@return a vector2d object with the required calculations done.
*/

/datum/vector2d/proc/operator/(datum/vector2d/b)
	if(isnum(b))
		return new /datum/vector2d(x/b, y/b)
	else if(istype(b, /datum/vector2d))
		return new /datum/vector2d(x/b.x, y/b.y)

/*
Method to overload the *= operator to multiply the X,Y coordinates to our own ones, without making a new vector2d
*/
/datum/vector2d/proc/operator*=(datum/vector2d/b)
	if(isnum(b))
		x *= b
		y *= b
	else if(istype(b, /datum/vector2d))
		x *= b.x
		y *= b.y

/datum/vector2d/proc/operator~=(datum/vector2d/b)
	return (istype(b, /datum/vector2d) && x == b.x && y == b.y)

/datum/vector2d/proc/to_string()
	return "([src.x], [src.y])"

/datum/vector2d/proc/dot(var/datum/vector2d/other)
	return src.x * other.x + src.y * other.y

/datum/vector2d/proc/ln2()
	return src.dot(src)

/datum/vector2d/proc/ln()
	return sqrt(src.ln2())

/datum/vector2d/proc/normalize()
	return src / src.ln()

/datum/vector2d/proc/project(var/datum/vector2d/other)
	var/amt = src.dot(other) / other.ln2()
	src.x = amt * other.x
	src.y = amt * other.y
	return src

/datum/vector2d/proc/project_n(var/datum/vector2d/other)
	var/amt = src.dot(other)
	src.x = amt * other.x
	src.y = amt * other.y
	return src

/datum/vector2d/proc/reflect(axis)
	src.project(axis)
	src *= -2

/datum/vector2d/proc/reflect_n(axis)
	src.project_n(axis)
	src *= -2

/datum/vector2d/proc/perp()
	var/newx = src.y
	var/newy = -src.x
	src.x = newx
	src.y = newy
	return src

/datum/vector2d/proc/copy(var/datum/vector2d/other)
	src.x = other.x
	src.y = other.y
