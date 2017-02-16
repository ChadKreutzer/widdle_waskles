# review name
testemonials = [
  [
		"Just got my 2 kiddos groomed today. Jenna is amazing! My dogs and I felt at home as soon as we walked in. She really focuses on them feeling relaxed and not scared. My dogs were happy and loving on her when we picked them up. My kiddos smell so yummy. I will be taking them to her regularly. I highly recommend Widdle Waskles!",
		"Deb Bokelman"
	],
	[
		"Jenna is amazing. She just groomed our extremely matted mini schnauzer and was able to save all his feathers. Her disposition with him was amazing too. Couldn't be more happy with the experience! It's extremely hard to find a good groomer, but we finally found an extremely talented one!!",
		"Brit Adler"
	],
	[
		"Thank you so much for taking care of my fur baby. She is shy and hates going to other groomers but you made my baby feel so comfortable. I will never go back to a big groomer again.",
		"Holli Willett Petty"
	],
	[
		"Jenna is by far the best groomer I've ever used. I have an aggressive dog who is very apprehensive around strangers. I never took her to get groomed out of fear that she would bite the groomer. After seeing how good Jenna was with my other dog I gave it a chance. Not only did she calm my dog down it was actually a fun and pleasant experience for her. Now my dog can stay cool and heathy for the rest of the summer. Thank you Jenna!!!!!",
		"Angie Emery-Morrissey"
	],
	[
		"Jenni did an AMAZING job on my puppy! Best grooming experience we've had yet and will be returning.",
		"Leslie Sorter Neiman"
	],
	[
		"Jenna is AHmazing! We just moved here from Jersey and I found her through google, read reviews and knew this was the place to take my babies! She is did exceptional job on my Liska. Not only is Jenna talented, but very kind to me and my furbaby! I highly recommend her!",
		"Joanna Doroba-DiPersio"
	],
	[
		"I am so happy to have found Jenna. My 2 chihuahuas have had a few negative nail trimming experiences which have made them very anxious around groomers. Jenna immediately put them at ease. She took the time to get to know them first and comforted them through the whole process. Their nails look great and their emotions were not compromised! Thank you, Jenna, you are a very special person.",
		"Jamie Gebicki Hays"
	],
	[
		"Jenna did an amazing job on my little grand-dogs! They look wonderful. Thank you so much!!",
		"Desiree White Peppler"
	],
	[
		"Jenna is amazing. She does such a great job on my golden, Skyler. On top of her doing such a wonderful job she is really a nice, and sweet person! Thanks for all you do Jenna. Skyler and I love ya.",
		"Michelle Scherbarth"
	],
	[
		"FINALLY A GROOMER THAT LISTENS AND REALLY CARES!!! smile emoticon Jenna gave my 4 year old shitzu the BEST cut she has ever had. This is the first time ever, that I have not had to fix the cut myself at home. VERY HAPPY CUSTOMER!!!",
		"Lisa Bronson Wagner"
	],
	[
		"My goldens have been groomed by Jenna since they were puppies and no one can do them as well, We also have a Lhasa and no one can do him except Jenna. I would recommend her to all!",
		"Patt Spaunburg Barrett"
	],
	[
		"Amazing! My dogs have never been happier and they always want to stay longer.",
		"Jonae Nelson"
	],
	[
		"Caring and knowledgeable! Definitely going back in the future!",
		"Sophie Cottrill"
	],
	[
		"Best groomer ever!!",
		"Kimberly D Kincaid"
	]
]

testemonials.each do | review, name |
  Testimonial.create(review: review, name: name)
end

# service pet_type price
services = [
  [
		"Standard Bath",
		"Dog and Cat",
		"Estimate"
	],
	[
		"Nail Clip",
		"Dog and Cat",
		"Estimate"
	],
	[
		"Behavior Modification",
		"Dog",
		"Estimate"
	]
]

services.each do | service, pet_type, price |
  Service.create(service: service, pet_type: pet_type, price: price)
end

# url caption
photos = [
  [
		"images/blue_wall.jpg",
		"Shaggy dog looking good in front of a blue wall."
	],
	[
		"images/pretty_malmute.jpg",
		"Pretty Malmute laying on the grass"
	],
	[
		"images/terrier.jpg",
		"Hippy terrier on the lawn"
	],
	[
		"images/two_terriers.jpg",
		"A couple cousins looking good"
	],
	[
		"images/westie.jpg",
		"Red collars suit a white dog"
	]
]

photos.each do | review, name |
  Photo.create(url: url, caption: caption)
end
