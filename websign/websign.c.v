module websign

#flag -lwebsign -lstr -larr -lmap -lpthread -g -g3 -ggdb -w
#include <Net/web.h>

#include <time.h>
#include <pthread.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <openssl/ssl.h>
#include <openssl/err.h>

#include <str.h>
#include <arr.h>
#include <map.h>
#include <OS/file.h>
#include <Net/request.h>

#include "@VMODROOT/websign/test.c"
pub fn C.convert(voidptr, int) &&C.Control
pub fn C.convert_css(voidptr, int) &&C.CSS

pub struct C.String {
    data                        &char
    idx                         int
}

pub fn C.NewString(&char) C.String

pub struct C.Map {
    arr                         &voidptr
    idx                         int
}

pub fn C.NewMap() C.Map
pub fn C.AppendKey(&C.Map, &char, &char) int

pub struct C.Array {
    arr                         &voidptr
    idx                         int
}

pub fn C.NewArray(&voidptr) C.Array
pub fn C.Array__Append(&C.Array, voidptr) int
pub fn C.DestructArray(&C.Array)

pub enum StatusCode {
    ok = 200
}

@[typedef]
pub enum ControlTag {
    no_tag                              = 8490

    html_tag                            = 8491
    head_tag                            = 8492
    body_tag                            = 8493

    title_tag                           = 8494
    h1_tag                              = 8495
    h2_tag                              = 8496
    h3_tag                              = 8497
    input_tag                           = 8498
    p_tag                               = 8499
    div_tag                             = 8500
    a_tag                               = 8501
    pre_tag                             = 8502
    button_tag                          = 8503
    form_tag                            = 8504
}

@[typedef]
pub struct C.Cookie {
    name            &char
    value           &char
    Path            &char
    expires         int
    maxage          int
    HTTPOnly        int
}

@[typedef]
pub struct C.CSS {
    Class           &char
    Data            &char
    Selector        int
}

@[typedef]
pub struct C.Control {
    Parent              voidptr
    Tag                 ControlTag        // ControlTag
    ID                  &char
    Type                &char             // Type for <input> <button> <select> <script>
    Text                &char             // text for tags: <p> <h1> <h2> <h3>
    Class               &char             // class=""
    href                &char             // href for <a>
    CSS                 &&char             // CSS Function Generator for the tag <div style="CSS FUNCTION"></div>
    CSSCount            int
    Data                &char             // For Any Other Data In the Opening Tag <div Data... > </div>
    OnClick             int               // Enable this to 1 and Use FormID and DisplayID
    OnClickJS           &char 
    FormID              &char
    DisplayID           &char
    SubControls         voidptr
    SubControlCount     int
}

@[typedef]
pub struct C.WebRoute {
    Name                &char             // Name of route
    Path                &char             // Route
    Template            &char

    Handler             voidptr             // Web Route Handler

    CSS                 &&C.CSS               // 2D Array CSS_SELECTOR_NAME => CSS_DATA (Cache)
    CSS_Count           int

    ReadOnly            int           // Use Template Only
    Controls            &&C.Control
    ControlCount        int
}

@[typedef]
pub struct C.cWS {
    IP                  C.String
    Port                int
    Socket              int
    CFG                 C.WebServerConfig
    Logs                C.String
}

@[typedef]
pub struct C.WebServerConfig {
    DirRouteSearch      int             // Search for new route pages in a directory

    Routes              &&C.WebRoute
    RouteCount          int

    Index               C.WebRoute
    Err404              &char
}

@[typedef]
pub struct C.cWR {
    Route               C.String
    FullRoute           C.String
    RequestType         C.String
    Headers             C.Map
    Queries             C.Map
    Body                C.String

    Elapsed             f64
}

pub fn C.StartWebServer(C.String, int, int) &C.cWS
pub fn C.SetDefaultHeaders()
pub fn C.RunServer(&C.cWS, int, &char)
pub fn C.ParseAndCheckRoute(args &voidptr)
pub fn C.ParseRequest(&char) &C.cWR
pub fn C.ParseCookies(&C.cWR, C.String) int
pub fn C.GetPostQueries(&C.cWS, &C.cWR)
pub fn C.RetrieveGetParameters(&C.cWS, &C.cWR)
pub fn C.SendResponse(&C.cWS, int, int, C.Map, C.Map, &char)
pub fn C.web_body_var_replacement(C.Map, &char) C.String
pub fn C.fetch_cf_post_data(&C.cWS, &C.cWR, int)
pub fn C.GetSocketIP(int) &char
pub fn C.CreateCookies(&&C.Cookie) C.Map
pub fn C.statuscode_to_str(C.StatusCode) &char
pub fn C.DestroyServer(web C.cWS)
pub fn C.DestroyReq(&C.cWR)

pub fn C.EnableLiveHandler(&C.cWS) int
pub fn C.SearchRoute(&&C.cWS, &char)
pub fn C.AddCSS(&C.WebRoute, &voidptr) int
pub fn C.AddRoutes(&C.cWS, &C.WebRoute) int
pub fn C.AddRoute(&C.cWS, C.WebRoute) int
pub fn C.AddRoutePtr(&C.cWS, &C.WebRoute) int
pub fn C.AddCSS(&C.WebRoute, voidptr) int
pub fn C.control2str(&C.Control)
pub fn C.DestroyCfg(&C.WebServerConfig)


pub fn C.FindTag(&C.Control) &char
pub fn C.FindTagType(&char) ControlTag
pub fn C.ConstructTemplate(&C.WebRoute, &&C.Control, &&C.CSS) int
pub fn C.UpdateUI(&C.cWS, &C.cWR, &C.Control, &&C.Control, &&C.CSS)
pub fn C.ConstructCSS(&C.WebRoute) &char
pub fn C.decode_input_symbols(&char) &char
pub fn C.count_tabs(&char) int
pub fn C.proccess_html_line(&char) &&C.Control
pub fn C.ParseHTMLContent(&char) &&C.Control

pub fn C.ConstructHandler(int, int, int, int, int) C.String
pub fn C.ChangeElement(int, &&char) C.String

pub fn C.CreateRoute(&char, &char, voidptr) &C.WebRoute
pub fn C.SetReadOnly(&C.WebRoute, &char) int
pub fn C.DestroyWebRoute(&C.WebRoute)

pub fn C.CreateControl(int, &char, &char, &char, &&C.Control) &C.Control
pub fn C.Control__AppendControlAt(&C.Control, int, &C.Control) int
pub fn C.Control__AppendControlIn(&C.Control, int, &C.Control) int
pub fn C.Control__SetBuffer(&C.Control, &char) int
pub fn C.SetStyle(&C.Control, &&char) int

pub fn C.stack_to_heap(C.Control) &C.Control
pub fn C.Control__AppendStackControl(&C.Control, C.COntrol) int
pub fn C.AppendControl(&C.Control, &C.Control) int
pub fn C.AppendCSS(&C.Control, &char) int
pub fn C.create_index_line(int) &C.char
pub fn C.ControlClicked(&C.Control, C.Map) int
pub fn C.ConstructControl(&C.Control, int, int) C.String
pub fn C.DestructControl(&C.Control, int, int) voidptr
pub fn C.DestructControls(&C.Control) voidptr
pub fn C.DumpControls(&C.Control, int) C.String

pub fn C.CreateCSS(&char, int, &&char) &C.CSS
pub fn C.css_stack_to_heap(&C.CSS) &C.CSS
pub fn C.AppendDesign(&C.CSS, &char) int
pub fn C.DestroyCSS(&C.CSS) voidptr