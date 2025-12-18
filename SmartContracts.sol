// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title AyurvedaHerbsTraceability
 * @dev Contract for herb traceability with optimized stack usage
 */
contract AyurvedaHerbsTraceability {
    struct CollectionData {
        string herbName;
        string scientificName;
        string location; // Geolocation (e.g., "lat:long")
        uint256 quantity; // kg
        string soilType;
        string weatherConditions;
        uint256 collectionTime;
    }

    struct ProcessingData {
        string details;
        string equipmentUsed;
        string complianceHash; // SHA256 of compliance proof
    }

    struct TestingData {
        string results;
        string testLab;
        string testMethod;
        string complianceHash;
    }

    struct PackagingData {
        string location;
        string packageType;
        uint256 batchWeight; // kg
        string complianceHash;
        string qrCodeHash;
        uint256 packagingTime;
    }

    struct Batch {
        uint256 batchId;
        address collector;
        CollectionData collection;
        ProcessingData processing;
        TestingData testing;
        PackagingData packaging;
        bool isActive;
    }

    mapping(uint256 => Batch) public batches;
    uint256 public nextBatchId = 1;

    event BatchCreated(uint256 indexed batchId, address indexed collector);
    event ProcessingAdded(uint256 indexed batchId);
    event TestingAdded(uint256 indexed batchId);
    event Packaged(uint256 indexed batchId, string qrCodeHash);

    // Stage 1: Collection
    function createBatch(
        string memory herbName,
        string memory scientificName,
        string memory location,
        uint256 quantity
    ) external returns (uint256) {
        require(bytes(herbName).length > 0, "Herb name required");
        require(bytes(scientificName).length > 0, "Scientific name required");
        require(bytes(location).length > 0, "Location required");
        require(quantity > 0, "Quantity must be greater than 0");

        uint256 batchId = nextBatchId++;
        Batch storage batch = batches[batchId];
        batch.batchId = batchId;
        batch.collector = msg.sender;
        batch.collection.herbName = herbName;
        batch.collection.scientificName = scientificName;
        batch.collection.location = location;
        batch.collection.quantity = quantity;
        batch.collection.collectionTime = block.timestamp;
        batch.isActive = true;

        emit BatchCreated(batchId, msg.sender);
        return batchId;
    }

    function updateCollectionDetails(
        uint256 batchId,
        string memory soilType,
        string memory weatherConditions
    ) external {
        require(batchId > 0 && batchId < nextBatchId, "Batch does not exist");
        require(batches[batchId].isActive, "Batch not active");

        Batch storage batch = batches[batchId];
        batch.collection.soilType = soilType;
        batch.collection.weatherConditions = weatherConditions;
    }

    // Stage 2: Processing
    function addProcessing(
        uint256 batchId,
        string memory details,
        string memory equipmentUsed,
        string memory complianceHash
    ) external {
        require(batchId > 0 && batchId < nextBatchId, "Batch does not exist");
        require(batches[batchId].isActive, "Batch not active");
        require(bytes(details).length > 0, "Details required");

        Batch storage batch = batches[batchId];
        batch.processing.details = details;
        batch.processing.equipmentUsed = equipmentUsed;
        batch.processing.complianceHash = complianceHash;
        emit ProcessingAdded(batchId);
    }

    // Stage 3: Testing
    function addTesting(
        uint256 batchId,
        string memory results,
        string memory testLab,
        string memory testMethod,
        string memory complianceHash
    ) external {
        require(batchId > 0 && batchId < nextBatchId, "Batch does not exist");
        require(batches[batchId].isActive, "Batch not active");
        require(bytes(results).length > 0, "Results required");

        Batch storage batch = batches[batchId];
        batch.testing.results = results;
        batch.testing.testLab = testLab;
        batch.testing.testMethod = testMethod;
        batch.testing.complianceHash = complianceHash;
        emit TestingAdded(batchId);
    }

    // Stage 4: Packaging
    function packageBatch(
        uint256 batchId,
        string memory location,
        string memory packageType,
        uint256 batchWeight,
        string memory complianceHash
    ) external {
        require(batchId > 0 && batchId < nextBatchId, "Batch does not exist");
        require(batches[batchId].isActive, "Batch not active");
        require(bytes(location).length > 0, "Location required");
        require(batchWeight > 0, "Batch weight must be greater than 0");

        Batch storage batch = batches[batchId];
        batch.packaging.location = location;
        batch.packaging.packageType = packageType;
        batch.packaging.batchWeight = batchWeight;
        batch.packaging.complianceHash = complianceHash;
        batch.packaging.qrCodeHash = string(abi.encodePacked("AYUR-", toString(batchId), "-", toString(block.timestamp)));
        batch.packaging.packagingTime = block.timestamp;
        batch.isActive = false;

        emit Packaged(batchId, batch.packaging.qrCodeHash);
    }

    // Verification: Get full batch journey
    function getBatchJourney(uint256 batchId) external view returns (Batch memory) {
        require(batchId > 0 && batchId < nextBatchId, "Batch does not exist");
        return batches[batchId];
    }

    // Get batch by QR code hash
    function getBatchByQR(string memory qrCodeHash) external view returns (uint256) {
        for (uint256 i = 1; i < nextBatchId; i++) {
            if (keccak256(bytes(batches[i].packaging.qrCodeHash)) == keccak256(bytes(qrCodeHash))) {
                return i;
            }
        }
        revert("Batch not found");
    }

    // Helper to convert uint to string
    function toString(uint256 value) internal pure returns (string memory) {
        if (value == 0) return "0";
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + uint256(value % 10)));
            value /= 10;
        }
        return string(buffer);
    }
}