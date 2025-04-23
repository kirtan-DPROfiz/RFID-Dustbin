let latestCardID = '';
let reader;
let port;

window.initNFCReader = async function () {
  try {
    if (!port) {
     console.log("Attempting to connect to NFC reader..."); // Debug log
      console.log("Requesting NFC reader access...");
      console.log("1. Requesting serial port...");
      port = await navigator.serial.requestPort();
       console.log("2. Opening port (baudRate: 9600)...");
      await port.open({ baudRate: 9600 });

      // NFC Reader successfully connected!
      console.log("✅ NFC Reader is connected, you are ready to tap!");
    }

  console.log("3. Initializing reader...");
    reader = port.readable.getReader();
    const decoder = new TextDecoder();

    async function readCard() {
      try {
        const { value, done } = await reader.read();
        if (done) {
          reader.releaseLock();
          return;
        }

        const cardID = decoder.decode(value).trim();
        console.log("Card ID:", cardID);
        latestCardID = cardID;

        window.dispatchEvent(new CustomEvent('nfc-status', { detail: "connected" }));

        // Dispatch event to Flutter
        window.dispatchEvent(new CustomEvent('nfc-card-read', { detail: cardID }));

        readCard(); // Read next
      } catch (error) {
        console.error("CRITICAL ERROR:", err); // Detailed error
        console.error("Reading error:", error);
        cleanup();
      }
    }

    readCard();
  } catch (err) {
    console.error("❌ Failed to connect NFC reader:", err);
    cleanup();
  }
};

function cleanup() {
  if (reader) {
    reader.releaseLock();
    reader = null;
  }
}

window.getLatestCardID = function () {
  return latestCardID;
};

window.closeNFCReader = function () {
  cleanup();
  if (port) {
    port.close();
    port = null;
    console.log("NFC Reader disconnected");
  }
};