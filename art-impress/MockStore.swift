import Foundation

struct MockStore {
    static var cards = [
        Card(title: "Italy"),
        Card(title: "England"),
        Card(title: "Portugal"),
        Card(title: "Belgium"),
        Card(title: "Germany"),
        Card(title: "Mexico"),
        Card(title: "Canada"),
        Card(title: "Italy"),
        Card(title: "England"),
        Card(title: "Portugal"),
        Card(title: "Belgium"),
        Card(title: "Germany"),
        Card(title: "Mexico"),
        Card(title: "Canada"),
        Card(title: "England"),
        Card(title: "Portugal"),
        Card(title: "Belgium"),
        Card(title: "Germany"),
        Card(title: "Mexico"),
        Card(title: "Canada"),
    ]
    
    
    static var tags: ImageTags = ImageTags(
        tagGroups: [
            TagGroup(name: "Body parts",
                     tags: [Tag("hand",false),
                            Tag("leg",false),
                            Tag("head",false),
                            Tag("back",false)]),
            TagGroup(name: "Сentury",
                     tags: [Tag("IV",false),
                            Tag("V",false),
                            Tag("VI",false),
                            Tag("VII",false),
                            Tag("red",false),
                            Tag("zero",false)]),
            TagGroup(name: "Some group",
                     tags: [Tag("foo",false),
                            Tag( "bar",false)])
        ])
}
