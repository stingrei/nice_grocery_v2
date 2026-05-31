breakpoint = 980
isSp = false
timer = null
initNum = 0
position = 0

totalBlock = 4
headSize = 39
scrollWrapper = document.querySelector('.scroll-wrapper')

if window.innerWidth < breakpoint
  isSp = true


window.addEventListener "load", ()=>
  console.log('load')
  winH = window.innerHeight
  winW = window.innerWidth
  current_pos = window.scrollY
  current_btm = current_pos + winH
  # checkOrientation()

  document.documentElement.style.setProperty('--disp-height', winH + 'px')
  
  console.log(newsLoaded)
  if newsLoaded
    run()
  else
    document.addEventListener('news:loaded', run)
  
  

document.addEventListener 'DOMContentLoaded', ()=>
  winH = window.innerHeight
  winW = window.innerWidth
  current_pos = window.scrollY
  current_btm = current_pos + winH
  

window.addEventListener "resize", (event) =>
  if window.innerWidth < breakpoint
    isSp = true
  else
    isSp = false


scrollWrapper.addEventListener "scroll", (event) =>
  scrollFunction()

run = () =>
  scrollFunction()
  console.log('html生成完了')
  
  window.scrollTo
    top: 0
    behavior: 'instant'
  document.querySelector('#main').classList.add('init')
  flip()
  anchorLink()
  
  document.querySelectorAll('[data-hide]').forEach (btn) ->
    btn.addEventListener 'click', ->

      num = btn.dataset.hide
      target = document.querySelector('[data-hide-target="' + num + '"]')

      return unless target?

      if target.classList.contains('open')
        target.style.height = target.scrollHeight + 'px'
        requestAnimationFrame ->
          target.style.height = '0px'
      else
        target.style.height = target.scrollHeight + 'px'

      target.classList.toggle('open')

  document.querySelectorAll('[data-open]').forEach (btn) ->
    btn.addEventListener 'click', ->

      num = btn.dataset.open
      target = document.querySelector('[data-hide-target="' + num + '"]')

      return unless target?

      target.style.height = target.scrollHeight + 'px'

      target.classList.add('open')  
  
  
  
    
# スクロール時の処理
scrollFunction = ()->
  winH = scrollWrapper.clientHeight
  current_pos = scrollWrapper.scrollTop
  current_btm = current_pos + winH
  
  scrollObjects = document.querySelectorAll('.scroll-in')
  scrollObjects.forEach (scrollObject)=>
    if scrollObject.getBoundingClientRect().top < 5*(winH/6)
      scrollObject.classList.add('show')

  toggleObjects = document.querySelectorAll('.scroll-toggle')
  toggleObjects.forEach (toggleObject)=>
    if toggleObject.getBoundingClientRect().top < 3*(winH/6)
      toggleObject.classList.add('on')
    else
      toggleObject.classList.remove('on')

  toggleObjects = document.querySelectorAll('.scroll-toggle-bottom')
  toggleObjects.forEach (toggleObject)=>
    if toggleObject.getBoundingClientRect().top < 6*(winH/6)
      toggleObject.classList.add('bottom')
    else
      toggleObject.classList.remove('bottom')

  document.querySelectorAll('.section').forEach (section, i) ->
    headGap = (totalBlock - i ) * headSize
    # block.style.bottom = block.clientHeight * -1 + headMargin + 'px' 
    if section.getBoundingClientRect().top <= winH - headGap
      section.classList.add('on')
    else
      section.classList.remove('on')


# アンカーリンク登録
anchorLink = ()->
  anchorLinks = document.querySelectorAll('a[href^="#"]')
  anchorLinksArr = Array.prototype.slice.call(anchorLinks)

  anchorLinksArr.forEach (link)=>
    link.addEventListener 'click', (e)=> 
      e.preventDefault()
      targetId = link.hash
      targetElement = document.querySelector(targetId)
      gap = 0 
      if !isSp
        gap = 56
      targetOffsetTop = window.pageYOffset + targetElement.getBoundingClientRect().top - gap
      window.scrollTo({
        top: targetOffsetTop,
        behavior: "smooth"
      })

flip = ()->
  document.querySelectorAll('[data-flip-pic]').forEach (that)=>
    interval = parseFloat(that.getAttribute('data-flip-pic'))*1000
    children = that.children
    counter = 0
    delay = parseFloat(that.getAttribute('data-delay'))*1000
    
    flipCounter = (counter)=>
      children[counter].classList.add('show')
      time = interval
      if children[counter].getAttribute('data-time')
        time = parseFloat(children[counter].getAttribute('data-time'))*1000
      setTimeout =>
        children[counter].classList.remove('show')
        if children[counter+1]
          counter = counter+1
        else
          counter = 0
        flipCounter(counter)
      , time
      
    setTimeout =>
      flipCounter(counter)
    , delay

