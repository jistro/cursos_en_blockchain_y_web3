import React from 'react';
export default function Box(props) {
    //const [on, setOn] = React.useState(props.on)

    const colorB = props.on ? 'purple' : 'transparent'
    const styles = {
        backgroundColor: colorB
    }

    function toggle() {
        setOn(!on)
    }
    return (
        <div 
            className='box' 
            style={styles} 
            onClick={()=>props.setClick(props.id)}
        >
        </div>
    )
}