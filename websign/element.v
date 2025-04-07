module websign

@[typedef]
pub enum Element_T {
	__null__ 	= 0
	__box__ 	= 1
}

pub struct Sides {
	pub mut:
		left			int
		top 			int
		right 			int
		bottom 			int
}

pub struct Bounds {
	pub mut:
		x int
		y int
}

type Size = Bounds
type Position = Bounds
type Margin = Sides
type Padding = Sides

pub struct Element {
	pub mut:
		typ 			Element_T
		position 		Position
		size 			Size

		margin 			Margin
		padding			Padding

		background		int
		color 			int

		text 			string

		style			C.Array
		control 		&C.Control	// HTML Component
		css 			&C.CSS		// CSS Style (Generated name for the selector and component class value)
}

pub const (
	css_template = []string{
		"position: absolute", // element.undocked = 1
		"margin-top: [POS]", // element.margin.top
		"margin-left: [POS]", // element.margin.left
		"margin-right: [POS]", // element.margin.right
		"margin-bottom: [POS]", // element.margin.bottom
		"width: [SZ]", // element.size.x
		"height: [SZ]" // element.size.y
	}
)

// element.disable_overflow()
// element.

pub fn construct_template(controls []Element) {}

// pub fn create_new_element(tag ControlTag, sclass string, id string, text string, style []string) (Element, &C.CSS) {
// 	mut e := Element{
// 		tag: tag,
// 		class: sclass.str(),
// 		id: id.str(),
// 		text: text.str()
// 		control: C.CreateControl(int(tag), sclass.str, id.str, text.str, C.NULL)
// 	}

// 	mut css_data := C.NewArray(C.NULL)
// 	for ele in style {
// 		C.Array__Append(&css_data, ele.str)
// 	}

// 	// mut css := C.CreateCSS(sclass.str, 1, css_data.arr)
// 	// DestroyArray(css_data)
// 	mut css := &C.CSS{ Class: sclass.str, Selector: 1, Data: css_data.arr }

// 	return e, css
// }

pub fn create_new_box(shape Element_T, pos Position, size Size, margin Margin, text string controls []Element) Element {
	mut e := Element{
		typ: shape,
		position: pos,
		size: size,
		margin: margin,
		text: text
	}

	mut new_css_name = "ws_" + generate__name()
	mut id = generate__name()
	e.control = C.CreateControl(ControlTag.div_tag, new_css_name.str, id.str, text.str, C.NULL)

	return e
}

pub fn (mut e Element) set_background_n_text_color(bg string, text_color string) {
	if bg.starts_with("http://") || bg.starts_with("https://") {
		// background-image: url('')
    	// background-size: cover
    	// background-repeat: no-repeat
	}
}

pub fn (mut e Element) disable_browser_affects() {

}

pub fn generate__name() {
	for i in 1..127 {
		println("${i}")
	}
}