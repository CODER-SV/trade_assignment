📖 Approach & Implementation Details
1. Project Objective

The primary objective of this assignment was to design and implement a responsive, user-friendly mobile application UI as per the provided screens. The focus was on:

Ensuring pixel-perfect UI as per the given design.

Implementing responsiveness across different screen sizes and orientations.

Maintaining a smooth and intuitive user experience (UX).

Since the task was limited to UI/UX, no backend integration or actual API calls were implemented.

2. Design Decisions
a) Responsiveness

Used MediaQuery and LayoutBuilder to dynamically adapt layouts based on device width, height, and orientation.

Ensured that all UI elements scale proportionally, making the app look consistent across various devices and resolutions.

Adopted a fluid layout where heights and widths are dynamically calculated instead of using fixed values.

b) Menu Selection (Portrait vs. Landscape)

In portrait mode: The menu items are shown in a dropdown menu for compactness and ease of reach.

In landscape mode: The menu items expand and are displayed side by side for better visibility, utilizing the extra screen width.

This ensures that the UX adapts naturally to how users typically interact with devices in different orientations.

c) Logo & Assets

Since no official logo was provided, a placeholder logo was sourced from Google for demonstration purposes.

All icons, colors, and UI components were aligned with the design reference provided.

d) User Experience (UX) Focus

Key information and primary actions are kept within thumb reach to improve accessibility.

Navigation is designed to be smooth and intuitive, reducing the number of taps required to reach core features.

Ensured that content does not overflow on smaller devices and maintains proper spacing.

e) Interactivity

Buttons and UI components are designed as tappable, but actual functional logic (e.g., API integration, navigation flows) is not implemented, since the scope was limited to UI/UX.

This allows the focus to remain on visual accuracy and responsiveness.

3. Challenges & Solutions

Challenge: Making the same screen work seamlessly in both portrait and landscape modes.

Solution: Used a conditional rendering approach via LayoutBuilder and MediaQuery to toggle between dropdown (portrait) and expanded (landscape).

Challenge: Maintaining dynamic sizing across devices.

Solution: Avoided hard-coded sizes; instead relied on relative sizing (percentages of screen width/height).

4. Key Highlights

✅ Fully responsive design (portrait & landscape).
✅ Adaptive UI with conditional layouts.
✅ Placeholder assets used where official ones weren’t provided.
✅ Pixel-perfect implementation of the provided design.
✅ Focused on smooth, intuitive UX and accessibility.

5. Future Enhancements

If extended beyond UI/UX, the following features can be added:

API integration for real-time data.

Navigation flows between screens.

State management (e.g., Provider, Riverpod, or Bloc).

Theme support (dark mode / light mode).
