# ARH App Backend Integration

## Overview
Your Flutter ARH (Architecture Reality Helper) app has been successfully integrated with a Node.js/Express backend with MySQL database. The integration maintains your existing UI design while adding full API functionality.

## Backend API (http://localhost:3000)

### Authentication Endpoints
- `POST /api/auth/login` - Email/username/phone login
- `POST /api/auth/register` - User registration
- `POST /api/auth/send-verification` - Phone verification
- `POST /api/auth/verify-phone` - Verify phone code
- `POST /api/auth/reset-password` - Password reset

### Products Endpoints
- `GET /api/products` - Get products with filters (search, category, brand, price)
- `GET /api/products/:id` - Get single product
- `POST /api/products` - Create new product
- `PUT /api/products/:id` - Update product
- `DELETE /api/products/:id` - Delete product
- `GET /api/products/my-products` - Get user's products

### Categories & Brands
- `GET /api/metadata/categories` - Get all categories
- `GET /api/metadata/brands` - Get all brands
- `POST /api/metadata/categories` - Create category
- `POST /api/metadata/brands` - Create brand

### Favorites
- `GET /api/favorites` - Get user's favorites
- `POST /api/favorites` - Add to favorites
- `DELETE /api/favorites/:productId` - Remove from favorites

### AR Projects
- `GET /api/projects` - Get user's AR projects
- `POST /api/projects` - Create new project
- `PUT /api/projects/:id` - Update project
- `DELETE /api/projects/:id` - Delete project

### User Management
- `GET /api/users/profile` - Get user profile
- `PUT /api/users/profile` - Update profile
- `GET /api/users/preferences` - Get preferences
- `PUT /api/users/preferences` - Update preferences

## Flutter App Changes

### New Dependencies Added
```yaml
dependencies:
  http: ^1.1.0
  shared_preferences: ^2.2.2
  socket_io_client: ^2.0.3+1
```

### New Service Files Created
- `lib/services/api_service.dart` - Core HTTP client with auth token management
- `lib/services/auth_service.dart` - Authentication operations
- `lib/services/product_service.dart` - Product management
- `lib/services/metadata_service.dart` - Categories and brands
- `lib/services/favorites_service.dart` - Favorites management
- `lib/services/project_service.dart` - AR projects
- `lib/services/user_service.dart` - User profile management

### Updated Screens
- `lib/screens/login_screen.dart` - Integrated with backend auth
- `lib/screens/signup_screen.dart` - Integrated with user registration
- `lib/screens/StoreScreen.dart` - Loads products and categories from API
- `lib/screens/FavoritesScreen.dart` - Displays user's favorite products

### New Components
- `lib/widgets/auth_wrapper.dart` - Manages login state

## Test Credentials
For testing the integrated app, use these credentials:
- **Email**: `john@example.com` or `sarah@example.com`
- **Password**: `password123`

## How It Works

1. **Authentication Flow**:
   - User enters credentials in login screen
   - App calls `/api/auth/login` endpoint
   - Backend returns JWT token
   - Token stored in SharedPreferences for future API calls

2. **Data Loading**:
   - Screens load data from backend APIs
   - Fallback to static data if API fails (offline support)
   - Loading states shown while fetching data

3. **Error Handling**:
   - Network errors handled gracefully
   - User-friendly error messages displayed
   - Automatic token refresh when needed

## Key Features Integrated

### ✅ Authentication System
- Email, username, and phone login
- User registration with validation
- JWT token management
- Auto-logout on token expiry

### ✅ Product Management
- Dynamic product loading from database
- Search and filtering functionality
- Category-based browsing
- Product details and images

### ✅ Favorites System
- Add/remove products from favorites
- Persistent favorites storage
- Real-time updates

### ✅ User Profiles
- Profile management
- Preferences storage
- Authentication state management

## Database Structure
The MySQL database includes tables for:
- Users (authentication and profiles)
- Products (furniture and decor items)
- Categories and Brands
- Favorites
- AR Projects
- Chat messages
- Notifications
- SOS requests

## Next Steps

1. **Run the app**: Use `flutter run` to start the app
2. **Test features**: Try login, browsing products, adding favorites
3. **Customize**: Modify API endpoints or add new features as needed
4. **Deploy**: Backend can be deployed to any hosting service
5. **Add more features**: Implement chat, AR viewer, SOS system

## Development Commands

```bash
# Start backend server
cd arch_backend
npm run dev

# Start Flutter app
cd arh_app
flutter run

# Install new Flutter packages
flutter pub get

# Check for errors
flutter analyze
```

Your app now has a complete backend integration while maintaining the original design and user experience!
