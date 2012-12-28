Akari.biliScript
================

> akari / noun.
>
> 1. light; illumination; glow; gleam;
> 2. lamp; light

Akari.biliScript is an open source (also by nature of player scripts) helper for authoring Comment Arts in BiliPlayer, the comment player for bilibili.tv, with its distinctive mode-8 scripting capability. The helper provides, by design, seekability and the ability to fit its display regardless of player settings (as far as $.root remains accessible).

Akari.biliScript was originally written for Round and Round under the temporary name of "Comment Art Helper for submission Round and Round". It was renamed "Akari.biliScript" some time after the submission was made public.

(I insist that all documentary and comments be in English by the way.)

Akari.biliScript is not...
----------------------

* A magic header/footer that will make your Comment Art attractive in a second.
  
  No, it's just plain not possible. Fullscreen / widescreen capability are easy to add to any Comment Art, but just that won't take you anywere. Your contents are what people really care about.

* A script that make your life easier when you want to spit out a simple .lrc file on the screen.

  Though possible, it's an overkill. Akari.biliScript is designed and written to house really complex Comment Arts, preferably full-screen ones over a solid color video. When used for simple projects, the declarative descriptions of Compositions and Layers and all the Expression stuff will prove to be heavy burdens - while being powerful tools for authoring complex scenes. The built-in imperative API should be enough for such simple tasks.

* A script that depend on some insecure player hack in old versions in order to run as fast (well, "fast") as AS itself.

  No, Akari.biliScript does not, should not and will not use such hacks to improve performance. Keeping clean improves not only productivity, but also the longevity of your works.

* I want to play a game!

  No. Akari.biliScript is tailored to presenting pre-designed scenes, and provides absolutely no support for interactive elements. Once your MainComposition is up and running, modifying it can cause nothing but problems.

* A quick tool for creating your own version of some uncreative stuff.

  You can. But... do me a personal favor and don't.

Contribute
==========

You are welcome to make any improvements to the Akari.* namespaces, as well as writing your own extension namespaces! Just keep in mind that:

1. Keep the Akari.* namespaces generic.

   Those namespaces are only for the most essential and generic stuff. Complex and/or esoteric Effects and such should be in their own, or your personally named namespaces. This is to keep a "essentials" copy clean and short (it is already pretty long now!)

2. Keep up the extensive comments and follow my code formatting style.

   The extensive comments help users and other contributers know what your script is doing, making it easier to use/improve the helper. It also promotes consistency and beauty as a whole. Meanwhile, with so many mode-8 Comment Artists not knowing that much about the platform, it can promote literacy as well.

License
=======

Akari.biliScript is licensed under GNU GPLv3. Please read Akari.Template.biliScript for details.
