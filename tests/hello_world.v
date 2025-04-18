import time
import websign

pub struct WebServer {
    ip      string
    port    int
}

const __testing__ = [
	websign.Element{ },
	websign.Element{ },
]

pub fn index_html(web &C.cWS, r &C.cWR, mut route &C.WebRoute, socket int) {
	println("Index Template Constructor Executing....")

	mut controls := C.NewArray(C.NULL)
	mut css_style := C.NewArray(C.NULL)

	mut scss := C.NewArray(C.NULL)
	C.Array__Append(&scss, c"background-color: #000; color: #fff")
	C.Array__Append(&scss, C.NULL)

	C.Array__Append(&css_style, &C.CSS{ Class: c"body", Selector: 0, Data: scss.arr })
	C.Array__Append(&css_style, C.NULL)

	mut body, body_css := websign.create_new_element(websign.ControlTag.body_tag, "body", "", "", [
		"background-color: #000",
		"color: #fff",
		C.NULL
	])
	mut head, _ := websign.create_new_element(websign.ControlTag.head_tag, "", "", "", [])

	mut title := C.CreateControl(8494, C.NULL, C.NULL, c"Hello World", C.NULL)
	C.Array__Append(&controls, head)
	

	mut pt := C.CreateControl(8499, C.NULL, C.NULL, c"Hello Websign from V", C.NULL)
	C.Array__Append(&controls, body)
	C.Array__Append(&controls, C.NULL)
	
	control_set := C.convert(controls.arr, 2)
	css_set := C.convert_css(css_style.arr, 1)

	n := C.ConstructTemplate(route, &&C.Control(control_set), &&C.CSS(css_set))
	if n <= 0 {
		println("failed ${n}")
	}

	C.DestructArray(&controls)
	C.DestructArray(&css_style)
	C.DestructArray(&scss)
}

pub fn test(web &C.cWS, r &C.cWR, mut route &C.WebRoute, socket int) {
	index_html(web, r, mut route, socket)
    new_headers := C.NewMap()
    C.AppendKey(&new_headers, c'Content-Type', c'text/html; charset=UTF-8')
    C.AppendKey(&new_headers, c'Connection', c'close')

    C.SendResponse(web, socket, 200, &new_headers, C.Map{arr: C.NULL}, route.Template)
}

fn main() {
    web := C.StartWebServer(C.NewString(c""), 50, 0)
    if web == C.NULL {
        println("ERROR")
    }

	new_route := C.CreateRoute(c"index", c"/", voidptr(test))
    C.AddRoutePtr(web, new_route)

    C.RunServer(web, 99, C.NULL)

    for {
        time.sleep(1 * time.second)
    }
}
