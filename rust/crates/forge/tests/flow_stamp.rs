//! The written check's tree stamp (lib.rs flow_stamp): the guides stage takes a start's written-check
//! tree only when it was written from the same route with the same writer inputs.

use forge::flow_stamp;

#[test]
fn the_stamp_follows_the_route_and_the_guides_key() {
	let d = std::env::temp_dir().join(format!("forge-flow-stamp-{}", std::process::id()));
	let _ = std::fs::remove_dir_all(&d);
	std::fs::create_dir_all(&d).unwrap();
	let route = d.join("Orc.json");
	std::fs::write(&route, br#"{"start":"Orc","order":[1,2,3]}"#).unwrap();
	let a = flow_stamp("guides-key-1", &route).unwrap();
	assert_eq!(a, flow_stamp("guides-key-1", &route).unwrap(), "the same route and key: the same stamp");
	assert_ne!(a, flow_stamp("guides-key-2", &route).unwrap(), "another writer input (guides key): another stamp");
	// A rejected written-check round: the routes go back to the round before, the tree stays.
	std::fs::write(&route, br#"{"start":"Orc","order":[1,3,2]}"#).unwrap();
	assert_ne!(a, flow_stamp("guides-key-1", &route).unwrap(), "another route: another stamp");
	assert!(flow_stamp("guides-key-1", &d.join("absent.json")).is_err(), "no route file: no stamp");
	let _ = std::fs::remove_dir_all(&d);
}
