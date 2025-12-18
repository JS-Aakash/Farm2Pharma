# 🌿 Farm2Pharma

### Blockchain-Powered Supply Chain Tracking for Ayurvedic Herbs

[![Ethereum](https://img.shields.io/badge/Ethereum-Sepolia-3C3C3D?style=for-the-badge&logo=Ethereum&logoColor=white)](https://sepolia.etherscan.io/)
[![Solidity](https://img.shields.io/badge/Solidity-0.8.19-363636?style=for-the-badge&logo=solidity&logoColor=white)](https://soliditylang.org)
[![IPFS](https://img.shields.io/badge/IPFS-Pinata-65C2CB?style=for-the-badge&logo=ipfs&logoColor=white)](https://pinata.cloud)

> **Ensuring authenticity and transparency in herbal pharmaceuticals from farm to consumer using blockchain technology.**

---

## 📋 Overview

**Farm2Pharma** is a decentralized application (dApp) that creates an immutable, transparent record of every Ayurvedic herb batch's journey through the supply chain. Built on Ethereum blockchain with GPS tracking, compliance document verification, and QR code authentication, it eliminates counterfeit products and ensures quality.

### Key Features

- ✅ **Complete Traceability**: Track herbs from collection to packaging
- ✅ **Blockchain Verification**: Immutable records on Ethereum Sepolia testnet
- ✅ **GPS Integration**: Auto-capture location data at each stage
- ✅ **Document Hashing**: SHA-256 hashing + IPFS storage for compliance certificates
- ✅ **QR Code Verification**: Instant consumer verification via smartphone
- ✅ **Multi-Wallet Support**: MetaMask, WalletConnect, or read-only mode
- ✅ **Role-Based Access**: Dedicated interfaces for collectors, processors, testers, packagers

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────┐
│         Frontend (Single Page)          │
│  • HTML5 + Vanilla JavaScript           │
│  • Tailwind CSS + Leaflet.js            │
│  • Ethers.js for blockchain interaction │
└─────────────────────────────────────────┘
                     ↕
┌─────────────────────────────────────────┐
│       Ethereum Blockchain (Sepolia)     │
│  • Smart Contract: SupplyChainTracker   │
│  • Stores batch data on-chain           │
│  • Emits events for tracking            │
└─────────────────────────────────────────┘
                     ↕
┌─────────────────────────────────────────┐
│           IPFS (Pinata.cloud)           │
│  • Compliance documents storage         │
│  • Certificate PDFs                     │
│  • Document hashes stored on-chain      │
└─────────────────────────────────────────┘
```

---

## 🚀 Quick Start

### Prerequisites

- Modern web browser (Chrome, Firefox, or Brave recommended)
- [MetaMask](https://metamask.io/) browser extension (optional for consumers)
- A code editor and local web server (e.g., [VS Code Live Server](https://marketplace.visualstudio.com/items?itemName=ritwickdey.LiveServer))

### Installation

1. **Clone the Repository**
   ```bash
   git clone https://github.com/yourusername/farm2pharma.git
   cd farm2pharma
   ```

2. **Create Configuration File**
   
   Create `env.json` in the project root:
   ```json
   {
     "CONTRACT_ADDRESS": "0xYourContractAddressHere",
     "PINATA_JWT": "your_pinata_jwt_token",
     "SEPOLIA_CHAIN_ID": "11155111",
     "RPC_URL": "https://ethereum-sepolia.publicnode.com"
   }
   ```

   **How to get these values:**
   - `CONTRACT_ADDRESS`: Deploy `SmartContracts.sol` to Sepolia testnet using [Remix](https://remix.ethereum.org/)
   - `PINATA_JWT`: Sign up at [Pinata.cloud](https://pinata.cloud/) and create an API key
   - `RPC_URL`: Use the provided public node or get your own from [Infura](https://infura.io/) or [Alchemy](https://alchemy.com/)

3. **Start Local Server**
   ```bash
   # If using VS Code Live Server
   Right-click index.html → Open with Live Server
   
   # Or use Python
   python -m http.server 8000
   
   # Or use Node.js
   npx serve
   ```

4. **Open in Browser**
   Navigate to `http://localhost:8000` (or your server's URL)

---

## 📱 Usage

### For Supply Chain Participants

#### 1️⃣ **Collectors** (Farmers/Harvesters)
- Click "Collection" from the main menu
- Login with credentials (default: `collector1` / `collect123`)
- Fill in herb details (name, quantity, soil type, weather)
- GPS coordinates are auto-captured
- Submit transaction to create a new batch on blockchain

#### 2️⃣ **Processors** (Manufacturers)
- Login as processor (`processor1` / `process123`)
- Enter batch ID and processing details
- Upload compliance documents (auto-hashed and stored on IPFS)
- Record processing equipment and methods

#### 3️⃣ **Testers** (Quality Labs)
- Login as tester (`tester1` / `test123`)
- Submit batch ID and test results
- Upload quality certificates
- Mark tests as passed/failed

#### 4️⃣ **Packagers** (Distribution Centers)
- Login as packager (`packager1` / `package123`)
- Enter batch ID and packaging details
- Generate unique QR code for the batch
- Download QR code for product labels

### For Consumers

1. **Scan QR Code** on product packaging, or
2. **Enter Batch ID** manually in the Verification section
3. **View Complete Journey**: See collection → processing → testing → packaging
4. **Verify Documents**: Access compliance certificates from IPFS
5. **Check Locations**: View GPS-tracked supply chain on interactive map

**No wallet needed for verification!** Read-only mode automatically activates.

---

## 🔐 Security & Privacy

### Smart Contract Security
- ✅ Reentrancy protection
- ✅ Access control modifiers (role-based permissions)
- ✅ Integer overflow protection (Solidity 0.8+)
- ✅ Input validation on all functions

### Data Privacy
- GPS coordinates are public (blockchain transparency)
- User accounts managed via local storage
- Private keys never leave user's wallet
- Document content stored off-chain (IPFS)
- Only document hashes stored on-chain

### Authentication
- Multi-tiered wallet support (Desktop & Mobile)
- Fallback to read-only mode for consumers
- Demo mode for testing without testnet ETH

---

## 🌐 Deployment

This is a **static website** that can be hosted on any platform:

### Option 1: Vercel (Recommended)
```bash
# Install Vercel CLI
npm i -g vercel

# Deploy
vercel --prod
```

### Option 2: Netlify
```bash
# Drag and drop the folder to netlify.com, or use CLI
netlify deploy --prod --dir .
```

### Option 3: GitHub Pages
1. Push code to GitHub repository
2. Go to Settings → Pages
3. Select branch and `/` (root) folder
4. Click Save

**Important**: Ensure `env.json` is uploaded with your deployment!

---

## 📂 Project Structure

```
Farm2Pharma/
├── index.html              # Main application (single-page dApp)
├── documentation.html      # User guide and technical docs
├── SmartContracts.sol      # Ethereum smart contract source
├── env.json                # Configuration (⚠️ add to .gitignore)
├── .gitignore              # Git ignore file
├── README.md               # This file
└── Images/                 # Asset directory
```

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|-----------|
| **Frontend** | HTML5, Vanilla JavaScript, Tailwind CSS |
| **Blockchain** | Ethereum Sepolia, Solidity 0.8.19, Ethers.js |
| **Storage** | IPFS via Pinata API |
| **Maps** | Leaflet.js with OpenStreetMap |
| **QR Codes** | QRCode.js library |
| **Wallet** | MetaMask, WalletConnect |

---

## 📖 Smart Contract Functions

### Core Functions (from `SmartContracts.sol`)

```solidity
// Create a new batch
function createBatch(
    string herbName,
    string scientificName, 
    string location,
    uint256 quantity
) returns (uint256 batchId)

// Add processing information
function addProcessing(
    uint256 batchId,
    string details,
    string equipmentUsed,
    string complianceHash
)

// Record testing results
function addTesting(
    uint256 batchId,
    string results,
    string testLab,
    string testMethod,
    string complianceHash
)

// Package batch and generate QR
function packageBatch(
    uint256 batchId,
    string location,
    string packageType,
    uint256 batchWeight,
    string complianceHash
)

// Verify product journey (public view function)
function getBatchJourney(uint256 batchId)
    returns (BatchDetails)
```

---

## 🧪 Testing

### Local Testing with Demo Mode
The application includes a demo mode for testing without blockchain:
- No wallet required
- Simulated batch IDs
- Full UI/UX testing

### Testnet Testing
1. Get Sepolia ETH from [faucet](https://sepoliafaucet.com/)
2. Connect MetaMask to Sepolia network
3. Perform real blockchain transactions

---

## 🐛 Troubleshooting

### "Demo Mode" appears on desktop
- Ensure `env.json` is properly loaded (check browser console)
- Verify MetaMask is on Sepolia network
- Check that `CONTRACT_ADDRESS` is correct

### "Read-Only Mode" on mobile
- Expected behavior if wallet isn't connected
- Verification still works perfectly
- For write operations, use WalletConnect

### QR Scanner not working
- Allow camera permissions in browser
- Use HTTPS (required for camera access)
- Fallback: manually enter batch ID

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add YourFeature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

## 👥 Team

**Developed by**: Aakash JS

**Contact**: [jsaakash22@gmail.com]

**Project Link**: [https://github.com/JS-Aakash/Farm2Pharma](https://github.com/JS-Aakash/Farm2Pharma)

---

## 🙏 Acknowledgments

- Ethereum Foundation for blockchain infrastructure
- Pinata for decentralized storage
- OpenStreetMap contributors for mapping data
- Tailwind CSS for styling framework

---

<div align="center">

**[Live Demo](#) • [Documentation](documentation.html) • [Report Bug](#) • [Request Feature](#)**

Made with 💚 for transparent herbal supply chains

</div>