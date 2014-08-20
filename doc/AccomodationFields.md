ACCOMODATION SCHEMA
===================
*(mainly for student accomodation)*

- Types:
  - Sale
    - House vs Flat
  - Rent
    - House vs Flat
  - Share
    - Room vs Flat/House Share

- Fields regardless of Type:
  - Title (string)
  - Description (text)
  - Type: (Flat, House, Other)
  - Size: (sqm)
  - Bedrooms (#)
  - Bathrooms (#)
  - Available From: (date)
  - Parking: (Garage, Street, On Property, None)
  - Smoking Allowed: (boolean)
  - Preferred Gender: (Male, Female, No Preference)
  - Pets Allowed: (boolean)
  - Price: (float)
  - Location: location_key

- Fields dependant on Type:
  - Sale:
    - Sale by (Owner, Adjency)
  - Rent:
    - Rent by (Owner, Adjency)
  - Share:
    - Share type: (Share a room, Share the flat/house)

### Final Fields:

```ruby
type: :for_rent, :for_sale, :sharing
title: string
description: text,
dwelling: :apartment, :house, :other
size: integer
bedrooms: integer
bathrooms: integer
available_from: date
parking: :garage, :street, :on_property
smoking_allowed: bool,
pref_gender: :male, :female, :no_pref
pets_allowed: bool
price: float                                # monthly if rent/share
advert_by: :owner, :adjency, :resident
share_type: :room_share, :home_share        # only used if share
places_available: integer                   # only used if rent/share
```



