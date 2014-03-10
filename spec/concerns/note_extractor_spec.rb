# encoding: UTF-8
require 'spec_helper'

describe NoteExtractor do

  let (:test_class) { Struct.new(:ignore) { include NoteExtractor } }
  let (:extractor) { test_class.new(:ignore => true) }

  it "has removes original quoted message" do
    extractor.extract_note(%q{Dzisiaj właściwie nic nie zrobiłem.

Porozmawialiśmy. Na razie kontynuujemy z TS.

Teraz biorę się do pisania ogłoszenia.

Wiadomość napisana przez RemoteStandup <reminder-b3078c95-460c-4365-8b37-2e2d5729057e@in.remotestandup.com> w dniu 10 mar 2014, o godz. 17:00:

> --
> Please reply to this message and write down what you have been up to lately. The reply will be automatically forwarded to your team members and stored on our servers so you can review it later.
>
> It's good to write about:
>
> things you're grateful for
> any tasks you did finish
> any tasks that you wanted to finish but failed, treat them as a learning experience
> any obstacles you have and ideas to solve them
> Your reply will be forwarded to janek@teamstatus.tv
>
> If you have any questions or problems email pawel@remotestandup.com
>
>}).should == %q{Dzisiaj właściwie nic nie zrobiłem.

Porozmawialiśmy. Na razie kontynuujemy z TS.

Teraz biorę się do pisania ogłoszenia.
}.encode('utf-8')
  end

end