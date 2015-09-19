# DSLR Automation

To automate DSLRs, I use [gPhoto](https://github.com/gphoto) as a library and as a CLI (simple as, `apt-get install gphoto`).

## Focusing on the Stars

Getting crisp focus on stars with a DSLR is a pain in the neck! We need autofocus for long exposures. I don't care if it takes 20 min, as long as I can be kissing [Tracey](https://twitter.com/traceyann1972) under the stars while the machines autonomously take care of the tedious setup.

### Why not Infinity?

Just like in robotics, the [math never matches reality "Infinity" ≠ ∞](http://leyetscapes.com/edu/infinity-focus.html). Heat/cold causes things to change. Cameras are made to go "to infinity, and beyond!" so that autofocus PID controller can overshoot, etc. It changes by a couple microsteps throughout the night even. Even once automated, it's not perfectly repeatable because of backlash in the motor - have to approach from same direction and completely reset if it overshoots. All the same stuff as in robotics.

### Manual Solutions

Some manual suggestions include autofocusing on a distant street lamp or the moon if it's out, or to manually focus on a distant mountain during the day and then don't touch it until nighttime. Otherwise, you get is as close as possible by eye and then take *many* test shots.

### Automated Solution

I'm looking into algorithms to determine focus quality, but at the very least for now we can use [this bash script](focus.sh) to take test shots from which to choose the best setting. Then, use [this script](experiment.sh) to experiment with ISO, aperture, shutter speed, ... Finally, capturing the sky with [this one](capture.sh).

#### Example

Notice that ∞ is indeed blurry and it's not until about ∞-14 that it becomes clear. These are in microsteps ("Near1", smallest allow by Canon):

* ∞ ![Focus test ∞](focus-example/focus0.jpg)
* ∞-1 ![Focus test ∞-1](focus-example/focus1.jpg)
* ∞-2 ![Focus test ∞-2](focus-example/focus2.jpg)
* ∞-3 ![Focus test ∞-3](focus-example/focus3.jpg)
* ∞-4 ![Focus test ∞-4](focus-example/focus4.jpg)
* ∞-5 ![Focus test ∞-5](focus-example/focus5.jpg)
* ∞-6 ![Focus test ∞-6](focus-example/focus6.jpg)
* ∞-7 ![Focus test ∞-7](focus-example/focus7.jpg)
* ∞-8 ![Focus test ∞-8](focus-example/focus8.jpg)
* ∞-9 ![Focus test ∞-9](focus-example/focus9.jpg)
* ∞-10 ![Focus test ∞-10](focus-example/focus10.jpg)
* ∞-11 ![Focus test ∞-11](focus-example/focus11.jpg)
* ∞-12 ![Focus test ∞-12](focus-example/focus12.jpg)
* ∞-13 ![Focus test ∞-13](focus-example/focus13.jpg)
* ∞-14 ![Focus test ∞-14](focus-example/focus14.jpg)
* ∞-15 ![Focus test ∞-15](focus-example/focus15.jpg)
* ∞-16 ![Focus test ∞-16](focus-example/focus16.jpg)
* ∞-17 ![Focus test ∞-17](focus-example/focus17.jpg)
* ∞-18 ![Focus test ∞-18](focus-example/focus18.jpg)
* ∞-19 ![Focus test ∞-19](focus-example/focus19.jpg)
* ∞-20 ![Focus test ∞-20](focus-example/focus20.jpg)

![Stary night](focus-example/stary-night.jpg)
