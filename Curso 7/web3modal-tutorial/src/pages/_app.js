import '../styles/globals.css'
import { EthereumClient, w3mConnectors, w3mProvider } from '@web3modal/ethereum'
import { Web3Modal } from '@web3modal/react'
import { configureChains, createConfig, WagmiConfig } from 'wagmi'
import { goerli } from 'wagmi/chains'

export default function App({ Component, pageProps }) {
  const chains = [goerli]
//const projectId = process.env.PROJECT_ID_WALLETCONECT
const projectId = '954b44a42643bf4e4624a86cc282c835'
const { publicClient } = configureChains(chains, [w3mProvider({ projectId })])
  
  const wagmiConfig = createConfig({
    autoConnect: true,
    connectors: w3mConnectors({ projectId, chains }),
    publicClient
  })
  const ethereumClient = new EthereumClient(wagmiConfig, chains)
  
  return (
    <>
      <WagmiConfig config={wagmiConfig}>
        <Component {...pageProps} />
      </WagmiConfig>
      <Web3Modal 
        projectId={projectId} 
        ethereumClient={ethereumClient} 
        
      />
      
    </>
  )
}
