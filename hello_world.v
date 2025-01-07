import time
import websign

pub struct WebServer {
    ip      string
    port    int
}

pub fn index_html(web &C.cWS, r &C.cWR, route &C.WebRoute, socket int) {
	mut controls := []C.Control{}
	mut subcontrols := []C.Control{}
	mut styles := []C.CSS{}

	styles << &C.CSS{ Class: c'body', Selector: 0, Data: ([c'background-color: #000', c'color: #fff', C.NULL]).data }

	title := &C.Control{ 
		Tag: websign.ControlTag.title_tag, 
		Text: c'Test Page'
		OnClickJS: C.NULL,
		FormID: C.NULL,
		DisplayID: C.NULL,
		Data: C.NULL,
		ID: C.NULL,
		Type: C.NULL,
		Class: C.NULL,
		href: C.NULL,
		CSS: C.NULL,
		SubControls: C.NULL
	}

	controls << &C.Control{ 
		Tag: websign.ControlTag.head_tag, 
		OnClickJS: C.NULL,
		FormID: C.NULL,
		DisplayID: C.NULL,
		Data: C.NULL,
		ID: C.NULL,
		Type: C.NULL,
		Text: C.NULL,
		Class: C.NULL,
		href: C.NULL,
		CSS: C.NULL,
		SubControls: &&C.Control(&subcontrols)
	}
	
	C.ConstructTemplate(route, controls.data, styles.data)
}

pub fn test(web &C.cWS, r &C.cWR, route &C.WebRoute, socket int) {
    new_headers := C.NewMap()
    C.AppendKey(&new_headers, c'Content-Type', c'text/html; charset=UTF-8')
    C.AppendKey(&new_headers, c'Connection', c'close')

    C.SendResponse(web, socket, 200, &new_headers, C.Map{arr: C.NULL}, route.Template)
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
