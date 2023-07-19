import React from "react"

export default function App() {
    
    const [logInData, setLogInData] = React.useState(
        {
            email: "",
            password: "",
            passwordConfirm: "",
            okayToEmail: true
        }
    )
    
    function handleChange(event) {
        const{name, value, type, checked} = event.target
            setLogInData(prevLogInData => {
                return {
                    ...prevLogInData,
                    [name]: type === "checkbox" ? checked : value
                }
        })
    }

    function handleSubmit(event) {
        event.preventDefault()
        if (logInData.password !== logInData.passwordConfirm) {
            return alert("Passwords must match!")
        }
        if (logInData.okayToEmail) {
            alert("You have been added to the email list!")
        }
        console.log(logInData)
    }

    
    function handleSubmit(event) {
        event.preventDefault()
    }
    
    return (
        <div className="form-container">
            <form className="form" onSubmit={handleSubmit}>
                <input 
                    type="email" 
                    placeholder="Email address"
                    className="form--input"
                    name="email"
                    onChange={handleChange}
                    value={logInData.email}
                />
                <input 
                    type="password" 
                    placeholder="Password"
                    className="form--input"
                    name="password"
                    onChange={handleChange}
                    value={logInData.password}
                />
                <input 
                    type="password" 
                    placeholder="Confirm password"
                    className="form--input"
                    name="passwordConfirm"
                    onChange={handleChange}
                    value={logInData.passwordConfirm}
                />
                
                <div className="form--marketing">
                    <input
                        id="okayToEmail"
                        type="checkbox"
                        name="okayToEmail"
                        onChange={handleChange}
                        checked={logInData.okayToEmail}
                    />
                    <label htmlFor="okayToEmail">I want to join the newsletter</label>
                </div>
                <button 
                    className="form--submit"
                    type="submit"

                >
                    Sign up
                </button>
            </form>
        </div>
    )
}
