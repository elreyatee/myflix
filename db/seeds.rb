# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.create(title: "Daredevil", 
            description: "Blinded as a young boy, Matt Murdock fights injustice by day as a lawyer and by night as the Super Hero Daredevil in Hell's Kitchen, New York City.", 
            small_cover_url: "/tmp/daredevil.jpg", 
            large_cover_url: "/tmp/daredevil_large.jpg")
Video.create(title: "The Killing", 
            description: "Seattle homicide detectives Sarah Linden and Stephen Holder are deeply affected by the murders they investigate in this dark, acclaimed crime series.",
            small_cover_url: "/tmp/the_killing.jpg",
            large_cover_url: "/tmp/the_killing_large.jpg")
Video.create(title: "Family Guy", 
            description: "In a wacky Rhode Island town, a dysfunctional family strive to cope with everyday life as they are thrown from one crazy scenario to another.",
            small_cover_url: "/tmp/family_guy.jpg",
            large_cover_url: "/tmp/family_guy_large.jpg")
Video.create(title: "Futurama", 
            description: "Fry, a pizza guy is accidentally frozen in 1999 and thawed out New Year's Eve 2999.",
            small_cover_url: "/tmp/futurama.jpg",
            large_cover_url: "/tmp/futurama_large.jpg")
Video.create(title: "Archer", 
            description: "At ISIS, an international spy agency, global crises are merely opportunities for its highly trained employees to confuse, undermine, betray and royally screw each other.",
            small_cover_url: "/tmp/archer.jpg",
            large_cover_url: "/tmp/archer_large.jpg")
