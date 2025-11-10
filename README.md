# Ayurveda Herbs Traceability - Project Structure

## Overview
This application has been refactored from a single monolithic HTML file into a modular, scalable architecture with separated concerns for better maintainability and development.

## File Structure

```
public/
├── index.html                 # Main HTML structure
├── styles.css                 # All CSS styles and animations
├── README.md                  # This file
└── js/
    ├── config.js              # Configuration constants and app settings
    ├── contract.js            # Smart contract ABI definitions
    ├── utils.js               # Utility functions (hashing, IPFS, alerts)
    ├── ui.js                  # UI management and section navigation
    ├── auth.js                # Authentication and user management
    ├── wallet.js              # Wallet connection and blockchain functions
    ├── supply-chain.js        # Supply chain operations (collect, process, test, package)
    ├── verification.js        # Product verification and journey display
    ├── admin.js               # Admin panel and analytics
    └── main.js                # Application initialization and state management
```

## Key Features

### Modular Architecture
- **Separation of Concerns**: Each file handles a specific aspect of the application
- **Easy Maintenance**: Find and fix issues faster with organized code
- **Scalability**: Add new features without affecting existing functionality
- **Code Reusability**: Functions can be easily reused across different modules

### File Descriptions

#### `index.html`
- Main HTML structure and layout
- Contains all UI sections (menu, collection, processing, testing, packaging, verification, admin)
- Loads all external dependencies and application scripts in correct order

#### `styles.css`
- Custom CSS animations (spinner, fade-in, hover effects)
- Leaflet map customizations
- Chart container styling

#### `js/config.js`
- Smart contract address
- Blockchain network configuration (Sepolia)
- IPFS/Pinata JWT token
- Hardcoded user credentials
- Herb data mappings

#### `js/contract.js`
- Complete smart contract ABI
- All contract function signatures
- Input/output type definitions

#### `js/utils.js`
- `generateComplianceHash()` - SHA-256 hash generation
- `uploadToIPFS()` - IPFS file upload via Pinata
- `showLoading()` - Button loading state management
- `showAlert()` - Alert/notification system
- `getCurrentLocation()` - GPS location detection

#### `js/ui.js`
- `showSection()` - Section navigation
- `updateButtonStates()` - Dynamic button state management
- `initializeHerbSelector()` - Herb selection dropdown handler

#### `js/auth.js`
- User authentication (role-based)
- User management (add, delete, list)
- Admin authentication
- Modal management (login/logout)

#### `js/wallet.js`
- MetaMask wallet connection
- Network switching (Sepolia)
- Connection status management
- Demo mode support
- Account change handlers

#### `js/supply-chain.js`
- `collectHerb()` - Create new batch
- `updateCollectionDetails()` - Update collection data
- `addProcessing()` - Add processing information
- `addTesting()` - Add testing results
- `packageBatch()` - Package batch and generate QR
- QR code generation and download

#### `js/verification.js`
- `verifyJourney()` - Verify product by batch ID or QR code
- `displayBatchJourney()` - Display complete supply chain journey
- `displayComplianceDocuments()` - Show IPFS documents
- `verifyPDF()` - Verify document integrity
- `initializeMap()` - Display locations on interactive map
- QR scanner functionality

#### `js/admin.js`
- `loadAdminData()` - Load analytics data
- `updateHerbDistributionChart()` - Herb distribution chart
- `updateSupplyChainProgressChart()` - Supply chain progress chart
- Statistics calculation

#### `js/main.js`
- Application state management
- Initialization on page load
- Event listener setup
- Global state object (`appState`)

## Loading Order

The scripts must be loaded in this specific order (already configured in index.html):

1. **External libraries** (loaded in `<head>`)
   - ethers.js, Leaflet, QRCode, jsQR, PDF.js, Tailwind, Chart.js, WalletConnect

2. **Application scripts** (loaded before `</body>`)
   - config.js (constants)
   - contract.js (ABI)
   - utils.js (utilities)
   - ui.js (UI helpers)
   - auth.js (authentication)
   - wallet.js (blockchain connection)
   - supply-chain.js (core functionality)
   - verification.js (verification features)
   - admin.js (admin panel)
   - main.js (initialization)

## Global State

The `appState` object in `main.js` contains all global application state:

```javascript
{
    provider,                    // Ethers.js provider
    signer,                      // Ethers.js signer
    contract,                    // Smart contract instance
    map,                         // Leaflet map instance
    collectionMarker,            // Collection location marker
    packagingMarker,             // Packaging location marker
    video,                       // Video element for QR scanner
    canvas,                      // Canvas element
    qrScannerInterval,           // QR scanner interval ID
    isConnected,                 // Wallet connection status
    walletAddress,               // Connected wallet address
    currentQRCode,               // Current QR code
    currentUser,                 // Logged in user
    currentRole,                 // User's role
    herbDistributionChart,       // Chart.js instance
    supplyChainProgressChart     // Chart.js instance
}
```

## Default Users

The application includes hardcoded users for testing:

| Username     | Password    | Role      |
|-------------|-------------|-----------|
| admin       | admin123    | admin     |
| collector1  | collect123  | collector |
| processor1  | process123  | processor |
| tester1     | test123     | tester    |
| packager1   | package123  | packager  |

## Features

### Supply Chain Tracking
- **Collection**: Record herb collection with GPS coordinates
- **Processing**: Document processing methods and equipment
- **Testing**: Laboratory testing results and certificates
- **Packaging**: Generate unique QR codes for products

### Verification
- Scan QR codes or enter batch IDs
- View complete supply chain journey
- Interactive map showing collection and packaging locations
- Verify compliance documents on IPFS

### Admin Panel
- View total batches across all stages
- Herb distribution analytics (doughnut chart)
- Supply chain progress analytics (bar chart)
- User management

### Blockchain Integration
- Ethereum Sepolia testnet
- MetaMask wallet support
- Smart contract interaction
- Demo mode for testing without wallet

## Development

### Adding New Features

1. **New Supply Chain Stage**:
   - Add HTML section in `index.html`
   - Create function in `supply-chain.js`
   - Update contract ABI in `contract.js`

2. **New Admin Chart**:
   - Add canvas element in admin section
   - Create chart function in `admin.js`
   - Call from `loadAdminData()`

3. **New User Role**:
   - Add to `HARDCODED_USERS` in `config.js`
   - Create section in `index.html`
   - Add authentication logic in `auth.js`

### Testing

- Use demo mode without MetaMask connection
- Test all supply chain stages with demo data
- Verify QR code generation and scanning
- Check admin analytics with sample data

## Notes

- All functionality remains exactly the same as the original monolithic file
- No breaking changes to user experience
- Improved code organization for better maintainability
- Better separation of concerns following best practices
- Easier debugging and testing with modular structure

## Browser Compatibility

- Modern browsers with ES6 support
- MetaMask extension recommended
- Mobile browsers with camera access for QR scanning