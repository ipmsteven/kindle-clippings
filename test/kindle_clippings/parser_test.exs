defmodule KindleClippings.ParserTest do
  use ExUnit.Case

  test "can parse single line" do
    content = "Kindle User's Guide, 2nd Ed. (Amazon)
- Note Loc. 159  | Added on Tuesday, May 24, 2011, 06:15 PM

fuck you!
=========="

    parsed = KindleClippings.Parser.parse(content)
    assert parsed == [%KindleClippings{
      book: "Kindle User's Guide, 2nd Ed.",
      author: "Amazon",
      created: "Tuesday, May 24, 2011, 06:15 PM",
      body: "fuck you!"
    }]
  end

  test "can parse two lines" do
    content = "Kindle User's Guide, 2nd Ed. (Amazon)
- Note Loc. 159  | Added on Tuesday, May 24, 2011, 06:15 PM

fuck you!
==========
Nineteen Eighty-Four (Penguin Classics) (George Orwell)
- Highlight Loc. 2159  | Added on Friday, Jan 24, 2014, 04:33 PM

WAR IS PEACE IS SLAVERY IS IGNORANCE IS BLISS!\"
stood on that wall.
=========="

    parsed = KindleClippings.Parser.parse(content)
    assert parsed == [%KindleClippings{
      book: "Kindle User's Guide, 2nd Ed.",
      author: "Amazon",
      created: "Tuesday, May 24, 2011, 06:15 PM",
      body: "fuck you!"
    },
    %KindleClippings{
      book: "Nineteen Eighty-Four (Penguin Classics)",
      author: "George Orwell",
      created: "Friday, Jan 24, 2014, 04:33 PM",
      body: "WAR IS PEACE IS SLAVERY IS IGNORANCE IS BLISS!\"\nstood on that wall."
    }]
  end
end
