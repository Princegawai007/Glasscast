//
//  CLAUDE.md
//  Glasscast
//
//  Created by Prince Gawai on 17/01/26.
//

# Project Context: Glasscast

## Tech Stack
- **Platform:** iOS (SwiftUI) - Target iOS 17+
- **Architecture:** MVVM (Model-View-ViewModel)
- **Backend:** Supabase (Auth & Database)
- **Design System:** "Liquid Glass" (iOS 26 aesthetic)
  - Heavy use of .ultraThinMaterial and .glassEffect()
  - Translucency, blur, and depth
  - Dark mode compatible

## Core Features
1. **Auth:** Email/Password via Supabase.
2. **Weather:** OpenWeatherMap API (Free tier).
3. **Favorites:** Store city favorites in Supabase (favorite_cities table).
4. **UI:** Minimalist, glass-morphism, pull-to-refresh.

## Data Rules
- **Supabase Table:** favorite_cities
  - Columns: id (uuid), user_id (uuid), city_name (text), lat (float), lon (float), created_at (timestamp).
- **Security:** RLS enabled. Users can only read/write their own rows.

## Coding Standards
- NEVER hardcode Supabase keys or API tokens. Use Secrets.swift (gitignored).
- Always include error handling for network requests.
- Use AsyncImage for weather icons.
