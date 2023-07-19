import Head from 'next/head'
import Image from 'next/image'
import { Inter } from 'next/font/google'
import styles from '../styles/Home.module.css'
import {Web3Button} from '@web3modal/react'
import { useWeb3ModalTheme } from '@web3modal/react'
import { useContractRead, useContractWrite, parseGwei , usePrepareContractWrite } from 'wagmi'
import { ethers } from 'ethers';

import TutorialABI from '../abi/TutorialABI.json'

const inter = Inter({ subsets: ['latin'] })

export default function Home() {
  const { theme, setTheme } = useWeb3ModalTheme()

  setTheme({
    themeMode: 'dark',
    themeVariables: {
      '--w3m-font-family': 'Roboto, sans-serif',
      '--w3m-accent-color': '#FCACAC',
      '--w3m-accent-fill-color': '#FDDDDD',
      //'--w3m-logo-image-url': 'https://storage.mitaverse.world/img/2416.png',
      '--w3m-background-color': '#FCACAC',
      '--w3m-background-image-url': 'https://storage.mitaverse.world/img/2416.png',
    }
  })

  const { data: readNameNFT} = useContractRead({
    address: '0xf6cbbb46489ab645929f1bd92ab761e7229aaba9',
    abi: TutorialABI,
    functionName: "name",
  })


    const { config } = usePrepareContractWrite({
      address: '0xf6cbbb46489ab645929f1bd92ab761e7229aaba9',
      abi: TutorialABI,
      functionName: "purchase",
      args: [1],
      value: ethers.parseEther("0.000777"),
    })
    const { data, write: mintNFT } = useContractWrite(config)
   
        

  return (
    <>
      <Head>
        <title>Create Next App</title>
        <meta name="description" content="Generated by create next app" />
        <meta name="viewport" content="width=device-width, initial-scale=1" />
        <link rel="icon" href="/favicon.ico" />
      </Head>
      <main className={`${styles.main} ${inter.className}`}>
        <div>
          <Image
            src="/eth-diamond-rainbow.png"
            width={0}
            height={0}
            sizes="100vw"
            style={{ width: '20%', height: 'auto' }}
            
          />
          <h2 >
            Bienvenidos al tutorial de Web3Modal
          </h2>
          <div className={styles.grid}>
          </div>
          <Web3Button 
            //icon = 'hide'
            label = "Conectar wallet c:"
            balance = 'show'
          />
          <button 
            style={{
              marginTop: "1em",
              color: "black",
              borderRadius: 6,
              backgroundColor: "#FCACAC",
              height: 100,
            }}
            onClick={() => mintNFT?.()}
          >
            <p>Mintea {readNameNFT}</p>
            <Image
              src="/noggles.svg"
              width={0}
              height={0}
              sizes="100vw"
              style={{ width: '50%', height: 'auto' }}
              />
          </button>
        </div>
      </main>
    </>
  )
}
