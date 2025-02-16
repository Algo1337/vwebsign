module websign


pub struct Element {
	pub mut:
<<<<<<< Updated upstream
<<<<<<< Updated upstream
		Parent         	string
		Tag            	ControlTag
		ID             	string
		Type           	string
		Text           	string
		Class          	string
		href           	string
		CSS            	[]string
		Data           	string
		OnClick        	int
		OnClickJS      	string
		FormID         	string
		DisplayID      	string
		SubControls    	voidptr
		SubControlCount	int
}

pub fn new_element(ControlTag tag, string sclass, string id, string text) Element {
	mut e := Element{
		Tag: tag,
		Class: sclass,
		ID: id,
		Text: text
	}

	return e
}

pub fn (mut e Element) construct_element() int {

=======
=======
>>>>>>> Stashed changes
		parent         	string
		tag            	ControlTag
		id             	string
		etype          	string
		text           	string
		class          	string
		href           	string
		css            	[]string
		data           	string
		on_click       	int
		on_clickjs     	string
		formid         	string
		displayid      	string
		subcontrols    	[]C.Control

		control 		&C.Control
}

pub fn create_new_element(tag ControlTag, sclass string, id string, text string, style []string) (Element, &C.CSS) {
	mut e := Element{
		tag: tag,
		class: sclass.str(),
		id: id.str(),
		text: text.str()
		control: C.CreateControl(int(tag), sclass.str, id.str, text.str, C.NULL)
	}

	mut css_data := C.NewArray(C.NULL)
	for ele in style {
		C.Array__Append(&css_data, ele.str)
	}

	mut css := &C.CSS{ Class: sclass.str, Selector: 1, Data: css_data.arr }

	return e, css
}

pub fn (mut e Element) construct_element() int {
	return 1
<<<<<<< Updated upstream
>>>>>>> Stashed changes
=======
>>>>>>> Stashed changes
}