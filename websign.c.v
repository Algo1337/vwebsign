module websign

#flag -lwebsign -lstr -larr -lmap -lpthread -g -g3 -ggdb
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

pub enum WJS_Value_T {
    form_elements                       = 9040      // Provide a form ID <form id=""></form>
    element_ids                         = 9041      // Provide an array of element IDs
}

pub enum WJS_Action_T {
    no_action                           = 10930
    redirect                            = 10931
    msg_before_redirect                 = 10932
    get_results                         = 10933
    spin_until_results                  = 10934
    vertical_boomerang_until_results    = 10935
    horizontal_boomerang_until_results  = 10936
}

@[typedef]
pub struct C.CSS {
    Class           &char
    Data            &char
    Selector        int
}

@[typedef]
pub struct C.WJS {
    ValueType           WJS_Value_T         // OnClick Action Type
    Elements            voidptr             // Grab value of other elements using IDs
    Action              WJS_Action_T        // IF USING ANIMATION TAGS, AnimationID must be set.
    AnimationID         &char               // Element ID to the element you want animated
    ChangeID            &char               // Element ID to the element you want its value changed  
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
    Generator           voidptr             // Generator UI/UX Template

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

    Routes              C.WebRoute
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

    StartTime           C.clock_t
    EndTime             C.clock_t
    Elapsed             f64
}

pub fn C.StartWebServer(C.String, int, int) &C.cWS
pub fn C.RunServer(&C.cWS, int, &char)
pub fn C.ParseAndCheckRoute(args &voidptr)
pub fn C.ParseRequest(&char) &C.cWR
pub fn C.GetPostQueries(&C.cWS, &C.cWR)
pub fn C.RetrieveGetParameters(&C.cWS, &C.cWR)
pub fn C.SendResponse(&C.cWS, int, int, C.Map, C.Map, &char)
pub fn C.DestroyServer(web C.cWS)

pub fn C.SearchRoute(&&C.cWS, &char)
pub fn C.AddCSS(&C.WebRoute, &voidptr) int
pub fn C.AddRoutes(&C.cWS, &C.WebRoute) int
pub fn C.AddRoute(&C.cWS, C.WebRoute) int

pub fn C.AddDynamicHandler(&C.cWS) int
pub fn C.DestroyCfg(&C.WebServerConfig)
pub fn C.DestroyRoute(&C.WebRoute)

pub fn C.FindTag(&C.Control) &char
pub fn C.FindTagType(&char) ControlTag
pub fn C.ConstructTemplate(&C.WebRoute, &&C.Control, &&C.CSS) int
pub fn C.ConstructCSS(&C.WebRoute) &char
pub fn C.ConstructParent(&C.Control, int) C.String
pub fn C.ConstructOnClickForm(&C.Control) C.String
pub fn C.ConstructJS(&C.WJS) C.String
pub fn C.control2str(&C.Control) C.String
pub fn C.DumpControls(&C.Control, int) C.String

pub fn C.process_html_line(&data) &&C.Control
pub fn C.ParseHTMLContent(&char) &&C.Control