module websign


pub struct Element {
	pub mut:
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
}