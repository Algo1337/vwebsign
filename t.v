import websign

fn dick() {

}

fn main() {
	mut new_arr := []&C.Control{}

	mut head := C.CreateControl(8492, C.NULL, C.NULL, C.NULL, C.NULL)
	mut title := C.CreateControl(8494, C.NULL, C.NULL, c"Hello World", C.NULL)

	mut body := C.CreateControl(8493, C.NULL, C.NULL, C.NULL, C.NULL)
	mut pt := C.CreateControl(8499, C.NULL, C.NULL, c"Hello Websign from V", C.NULL)
	new_arr << head
	new_arr << body

	mut route := C.CreateRoute(c"nig", c"/", voidptr(dick))
	C.AppendParentControl(route, head)

	unsafe {
		C.ConstructTemplate(route, &&C.Control(new_arr.data), C.NULL)
	}

	println(route.Template)

}