import { ConnectButton, ConnectDialog } from "@connect2ic/react";
import React from "react";

import "./style.css";

const ConnectionPage = () => {
  return (
    <div className="container">
      <div className="heading_row">
        <div className="heading_text_col">
          <h4 className="heading_text1">D.</h4>
          <p className="heading_text2">Decentralized</p>
        </div>
        <div className="heading_text_col">
          <h4 className="heading_text1">A.</h4>
          <p className="heading_text2">Autonomous</p>
        </div>
        <div className="heading_text_col">
          <h4 className="heading_text1">O.</h4>
          <p className="heading_text2">Organization</p>
        </div>
      </div>
      <div className="connect_btn_block">
        <ConnectButton
          style={{
            borderRadius: "8px",
            width: "10rem",
            display: "flex",
            justifyContent: "center",
            alignItems: "center",
            textAlign: "center",
            border: "1px solid white",
            fontFamily: "Poppins",
          }}
        />
        <ConnectDialog dark={true} />
      </div>
    </div>
  );
};

export default ConnectionPage;
