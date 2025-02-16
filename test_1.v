import time 
import websign

pub fn index_html(mut route &C.WebRoute) {
	println("Index Template Constructor Executing....")

	mut gg := []C.Control{}
	mut controls := C.NewArray(C.NULL)
	mut css_style := C.NewArray(C.NULL)

	mut scss := C.NewArray(C.NULL)
	chk := C.Array__Append(&scss, c"background-color: #000")
	C.Array__Append(&scss, C.NULL)
	if chk <= 0 {
		println("HERE\n")
	}

	C.Array__Append(&css_style, &C.CSS{ Class: c"body", Selector: 0, Data: scss.arr })
	C.Array__Append(&css_style, C.NULL)

	mut head := C.CreateControl(8492, C.NULL, C.NULL, C.NULL, C.NULL)
	mut title := C.CreateControl(8494, C.NULL, C.NULL, c"Hello World", C.NULL)
	C.AppendControl(head, title)
	C.AppendControl(head, C.NULL)
	C.Array__Append(&controls, head)
	

	mut body := C.CreateControl(8493, C.NULL, C.NULL, C.NULL, C.NULL)
	mut pt := C.CreateControl(8499, C.NULL, C.NULL, c"Hello Websign from V", C.NULL)
	C.AppendControl(body, pt)
	C.AppendControl(body, C.NULL)
	C.Array__Append(&controls, body)
	C.Array__Append(&controls, C.NULL)
	
	control_set := C.convert(controls.arr, 2)
	css_set := C.convert_css(css_style.arr, 1)

	n := C.ConstructTemplate(route, &&C.Control(control_set), &&C.CSS(css_set))
	if n <= 0 {
		println("failed ${n}")
	}
}

fn main() {
	    web := C.StartWebServer(C.NewString(c""), 50, 0)
    if web == C.NULL {
        println("ERROR")
    }

	new_route := C.CreateRoute(c"index", c"/", C.NULL)
    C.AddRoutePtr(web, new_route)
	unsafe {
		web.CFG.Routes[0].ReadOnly = 1
		index_html(mut web.CFG.Routes[0])
		println(web.CFG.Routes[0].Template)
	}
}