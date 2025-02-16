module websign


pub struct Element {
	pub mut:
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

}