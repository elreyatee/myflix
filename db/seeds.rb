# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

drama = Category.create!(name: "Dramas")
action = Category.create!(name: "Action")
commedies = Category.create!(name: "Commedies")

Video.create!(title: "Daredevil", 
            description: "Blinded as a young boy, Matt Murdock fights injustice by day as a lawyer and by night as the Super Hero Daredevil in Hell's Kitchen, New York City.", 
            small_cover_url: "/tmp/daredevil.jpg", 
            large_cover_url: "/tmp/daredevil_large.jpg",
            category: action)
Video.create!(title: "The Killing", 
            description: "Seattle homicide detectives Sarah Linden and Stephen Holder are deeply affected by the murders they investigate in this dark, acclaimed crime series.",
            small_cover_url: "/tmp/the_killing.jpg",
            large_cover_url: "/tmp/the_killing_large.jpg",
            category: drama)
Video.create!(title: "Family Guy", 
            description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.",
            small_cover_url: "/tmp/family_guy.jpg",
            large_cover_url: "/tmp/family_guy_large.jpg",
            category: commedies)
Video.create!(title: "Futurama", 
            description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.",
            small_cover_url: "/tmp/futurama.jpg",
            large_cover_url: "/tmp/futurama_large.jpg",
            category: commedies)
Video.create!(title: "Archer", 
            description: "At ISIS, an international spy agency, global crises are merely opportunities for its highly trained employees to confuse, undermine, betray and royally screw each other.",
            small_cover_url: "/tmp/archer.jpg",
            large_cover_url: "/tmp/archer_large.jpg",
            category: commedies)
Video.create!(title: "Gone Girl",
            description: "With his wife's disappearance having become the focus of an intense media circus, a man sees the spotlight turned on him when it's suspected that he may not be innocent.",
            small_cover_url: "/tmp/gone_girl.jpg",
            large_cover_url: "/tmp/gone_girl_large.jpg",
            category: drama)
Video.create!(title: "Monk",
            description: "Adrian Monk is a brilliant San Francisco detective, whose obsessive compulsive disorder just happens to get in the way.",
            small_cover_url: "/tmp/monk.jpg",
            large_cover_url: "/tmp/monk_large.jpg", 
            category: commedies)
