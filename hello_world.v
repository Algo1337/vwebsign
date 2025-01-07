import time
import websign

pub struct WebServer {
    ip      string
    port    int
}

pub fn index_html(web &C.cWS, r &C.cWR, route &C.WebRoute, socket int) {
	controls := [
     &C.Control{ Tag: ControlTag.head_tag, SubControls: [
        	&C.Control{ Tag: ControlTag.title_tag, Text: c'Test Page' },
        	C.NULL,
        ]!},
    	C.NULL,
	]!
	
	C.ConstructTemplate(route, controls, C.NULL)
}

pub fn test(web &C.cWS, r &C.cWR, route &C.WebRoute, socket int) {
    new_headers := C.NewMap()
    C.AppendKey(&new_headers, c'Content-Type', c'text/html; charset=UTF-8')
    C.AppendKey(&new_headers, c'Connection', c'close')

    C.SendResponse(web, socket, 200, &new_headers, C.Map{arr: C.NULL}, c'Hello World')
}

fn main() {
    web := C.StartWebServer(C.NewString(C.NULL), 80, 0)
    if web == C.NULL {
        println("ERROR")
    }

    C.AddRoute(web, C.WebRoute{
        Name: c'index',
        Path: c'/',
        Handler: voidptr(test)
        Generator: voidptr(index_html)
        Template: C.NULL,
		Controls: C.NULL,
        CSS: C.NULL
    })

    C.RunServer(web, 99, C.NULL)

    for {
        time.sleep(1 * time.second)
    }
}
